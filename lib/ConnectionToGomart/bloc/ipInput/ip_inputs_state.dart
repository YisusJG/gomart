abstract class IpInputsState {
  String octetOne;
  String octetTwo;
  String octetThree;
  String octetFour;

  IpInputsState({
    this.octetOne = '',
    this.octetTwo = '',
    this.octetThree = '',
    this.octetFour = '',
  });
}

class OctetsState extends IpInputsState{
  OctetsState({
    required  super.octetOne,
    required  super.octetTwo,
    required  super.octetThree,
    required  super.octetFour,
  });
}
