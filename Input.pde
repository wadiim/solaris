public enum Input
{
  Q           (0b0000000000000001),
  W           (0b0000000000000010),
  E           (0b0000000000000100),
  R           (0b0000000000001000),
  A           (0b0000000000010000),
  S           (0b0000000000100000),
  D           (0b0000000001000000),
  SPACEBAR    (0b0000000010000000),
  LEFT_MOUSE  (0b0000000100000000),
  RIGHT_MOUSE (0b0000001000000000);
  
  private final int _code;
  
  Input(int code)
  {
    this._code = code;
  }
  
  int code()
  {
    return _code;
  }
}
