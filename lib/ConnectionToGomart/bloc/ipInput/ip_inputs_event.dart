abstract class IpInputsEvent {}

class OctetsEvent extends IpInputsEvent{
  final String octetOne;
  final String octetTwo;
  final String octetThree;
  final String octetFour;

  OctetsEvent({
    required this.octetOne,
    required this.octetTwo,
    required this.octetThree,
    required this.octetFour,
  });
}

