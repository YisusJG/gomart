package com.gomart.gomart

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.os.Bundle
import android.text.Html
import android.widget.CompoundButton

import android.widget.CompoundButton.OnCheckedChangeListener
import android.widget.TextView
import com.symbol.emdk.EMDKManager
import com.symbol.emdk.EMDKManager.EMDKListener
import com.symbol.emdk.EMDKManager.FEATURE_TYPE
import com.symbol.emdk.EMDKResults
import com.symbol.emdk.barcode.BarcodeManager
import com.symbol.emdk.barcode.BarcodeManager.ConnectionState
import com.symbol.emdk.barcode.BarcodeManager.ScannerConnectionListener
import com.symbol.emdk.barcode.ScanDataCollection
import com.symbol.emdk.barcode.Scanner
import com.symbol.emdk.barcode.Scanner.DataListener
import com.symbol.emdk.barcode.Scanner.StatusListener
import com.symbol.emdk.barcode.ScannerException
import com.symbol.emdk.barcode.ScannerInfo
import com.symbol.emdk.barcode.ScannerResults
import com.symbol.emdk.barcode.StatusData
import com.symbol.emdk.barcode.StatusData.ScannerStates

class MainActivity: FlutterActivity(), EMDKListener, DataListener, StatusListener, ScannerConnectionListener, OnCheckedChangeListener{

    private val CHANNEL = "barcode_channel"

    private var emdkManager: EMDKManager? = null
    private var barcodeManager: BarcodeManager? = null
    private var scanner: Scanner? = null
    private var textViewData: TextView? = null
    private var deviceList: List<ScannerInfo>? = null
    private var scannerIndex = 0 // Keep the selected scanner
    private var dataLength = 0
    private var bSoftTriggerSelected = false
    private var bExtScannerDisconnected = false
    private val lock = Any()
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val results = EMDKManager.getEMDKManager(applicationContext, this)
        if (results.statusCode != EMDKResults.STATUS_CODE.SUCCESS) {
            //updateStatus("EMDKManager object request failed!")
            return
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->

                when (call.method) {
                    "prueba" -> {
                        prueba()
                        result.success(null)
                    }
//                    "close" -> {
//                        closePrinter()
//                        result.success(null)
//                    }
//                    "startBarcodeScan" -> {
//                        startBarcodeScan()
//                        result.success(null)
//                    }
//                    "stopBarcodeScan" -> {
//                        stopBarcodeScan()
//                        result.success(null)
//                    }
                    else -> result.notImplemented()
                }


            }
    }


    private fun prueba() {
        // Lógica para cerrar la impresora
        println("Llego a prueba")
    }




    override fun onOpened(emdkManager: EMDKManager?) {
        print("EMDK open success!")
        this.emdkManager = emdkManager
        initBarcodeManager()
        enumerateScannerDevices()
    }

    override fun onResume() {
        super.onResume()
        if (emdkManager != null) {
            initBarcodeManager()
            enumerateScannerDevices()
            initScanner()
        }
    }

    override fun onPause() {
        super.onPause()
        // The application is in background
        // Release the barcode manager resources
        deInitScanner()
        deInitBarcodeManager()
    }


    override fun onClosed() {
        if (emdkManager != null) {
            emdkManager!!.release()
            emdkManager = null
        }
        print("EMDK closed unexpectedly! Please close and restart the application.")
    }

    override fun onDestroy() {
        super.onDestroy()
        // Release all the resources
        if (emdkManager != null) {
            emdkManager!!.release()
            emdkManager = null
        }
    }

    override fun onData(scanDataCollection: ScanDataCollection?) {
        if (scanDataCollection != null && scanDataCollection.result == ScannerResults.SUCCESS) {
            val scanData = scanDataCollection.scanData
            for (data in scanData) {
                updateData(data.data)
            }
        }
    }

    override fun onStatus(statusData: StatusData) {
        val state = statusData.state
        when (state) {
            ScannerStates.IDLE -> {
                if (bSoftTriggerSelected) {
                    scanner!!.triggerType = Scanner.TriggerType.SOFT_ONCE
                    bSoftTriggerSelected = false
                } else {
                    scanner!!.triggerType = Scanner.TriggerType.HARD
                }
                // submit read
                if (!scanner!!.isReadPending && !bExtScannerDisconnected) {
                    try {
                        scanner!!.read()
                    } catch (e: ScannerException) {
                        updateStatus(e.message!!)
                    }
                }
            }

            ScannerStates.WAITING -> {}
            ScannerStates.SCANNING -> {}
            ScannerStates.DISABLED -> {}
            ScannerStates.ERROR -> {}
            else -> {}
        }
    }

    override fun onConnectionChange(scannerInfo: ScannerInfo, connectionState: ConnectionState) {
        val status: String
        var scannerName = ""
        val statusExtScanner = connectionState.toString()
        val scannerNameExtScanner = scannerInfo.friendlyName
        if (deviceList!!.size != 0) {
            scannerName = deviceList!![scannerIndex].friendlyName
        }
        if (scannerName.equals(scannerNameExtScanner, ignoreCase = true)) {
            when (connectionState) {
                ConnectionState.CONNECTED -> {
                    bSoftTriggerSelected = false
                    synchronized(lock) {
                        initScanner()
                        bExtScannerDisconnected = false
                    }
                }

                ConnectionState.DISCONNECTED -> {
                    bExtScannerDisconnected = true
                    synchronized(lock) { deInitScanner() }
                }
            }
            status = "$scannerNameExtScanner:$statusExtScanner"
            updateStatus(status)
        } else {
            bExtScannerDisconnected = false
        }
    }

    private fun initScanner() {
        if (scanner == null) {
            if (deviceList != null && deviceList!!.size != 0) {
                if (barcodeManager != null) scanner =
                    barcodeManager!!.getDevice(deviceList!![scannerIndex])
            } else {
                updateStatus("Failed to get the specified scanner device! Please close and restart the application.")
                return
            }
            if (scanner != null) {
                scanner!!.addDataListener(this)
                scanner!!.addStatusListener(this)
                try {
                    scanner!!.enable()
                } catch (e: ScannerException) {
                    updateStatus(e.message!!)
                    deInitScanner()
                }
            } else {
                updateStatus("Failed to initialize the scanner device.")
            }
        }
    }

    private fun deInitScanner() {
        if (scanner != null) {
            try {
                scanner!!.disable()
            } catch (e: java.lang.Exception) {
                updateStatus(e.message!!)
            }
            try {
                scanner!!.removeDataListener(this)
                scanner!!.removeStatusListener(this)
            } catch (e: java.lang.Exception) {
                updateStatus(e.message!!)
            }
            try {
                scanner!!.release()
            } catch (e: java.lang.Exception) {
                updateStatus(e.message!!)
            }
            scanner = null
        }
    }

    private fun initBarcodeManager() {
        barcodeManager = emdkManager!!.getInstance(FEATURE_TYPE.BARCODE) as BarcodeManager
        // Add connection listener
        if (barcodeManager != null) {
            barcodeManager!!.addConnectionListener(this)
        }
    }

    private fun deInitBarcodeManager() {
        if (emdkManager != null) {
            emdkManager!!.release(FEATURE_TYPE.BARCODE)
        }
    }

    private fun addSpinnerScannerDevicesListener() {
        if (scannerIndex != 1 || scanner == null) {
            scannerIndex = 1
            bSoftTriggerSelected = false
            bExtScannerDisconnected = false
            deInitScanner()
            initScanner()
        }
    }

    private fun enumerateScannerDevices() {
        if (barcodeManager != null) {
            val friendlyNameList: MutableList<String> = java.util.ArrayList()
            var spinnerIndex = 0
            deviceList = barcodeManager!!.supportedDevicesInfo
            if (deviceList != null && deviceList!!.size != 0) {
                val it = deviceList!!.iterator()
                while (it.hasNext()) {
                    val scnInfo = it.next()
                    friendlyNameList.add(scnInfo.friendlyName)
                    if (scnInfo.isDefaultScanner) {
                        //defaultIndex = spinnerIndex;
                    }
                    ++spinnerIndex
                }
            } else {
                updateStatus("Failed to get the list of supported scanner devices! Please close and restart the application.")
            }
            addSpinnerScannerDevicesListener()
        }
    }

    private fun cancelRead() {
        if (scanner != null) {
            if (scanner!!.isReadPending) {
                try {
                    scanner!!.cancelRead()
                } catch (e: ScannerException) {
                    updateStatus(e.message!!)
                }
            }
        }
    }

    private fun updateStatus(status: String) {
        runOnUiThread {
            // textViewStatus.setText("" + status);
        }
    }

    private fun updateData(result: String?) {
        runOnUiThread {
            if (result != null) {
                if (dataLength++ > 100) { //Clear the cache after 100 scans
                    textViewData!!.text = ""
                    dataLength = 0
                }
                textViewData!!.append(Html.fromHtml(result))
                textViewData!!.append("\n")
//                (findViewById<View>(R.id.scrollViewData) as View).post {
//                    (findViewById<View>(
//                        R.id.scrollViewData
//                    ) as ScrollView).fullScroll(View.FOCUS_DOWN)
//                }
            }
        }
    }

    override fun onCheckedChanged(buttonView: CompoundButton?, isChecked: Boolean) {
        cancelRead()
    }
}
