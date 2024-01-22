class GiftsState{
  String errorApi;
  String message;

  GiftsState({
    this.message ="",
    this.errorApi = "",
  });
}


class SaveGiftsState extends GiftsState{
  SaveGiftsState({required super.message});
}

class ErrorSaveGifts extends GiftsState{
  ErrorSaveGifts({required super.errorApi});
}
