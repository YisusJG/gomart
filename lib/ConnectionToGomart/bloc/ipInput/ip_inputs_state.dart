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
    required  String octetOne,
    required  String octetTwo,
    required  String octetThree,
    required  String octetFour,
  }) : super(octetOne: octetOne, octetTwo: octetTwo,octetThree: octetThree,octetFour: octetFour);
}
