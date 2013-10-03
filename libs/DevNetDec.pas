unit DevNetDec;

interface

const
  fClb = 1; // весы в режиме 'калибровка'
  fClbZero = 2; // весы в режиме 'калибровка нуля'
  fStable = 4; // значения веса стабильны
  fNearZero = 8; // значения веса в диапазоне -0.5d..+0.5d
  fIsMin20d = 16; // значение веса меньше 20d
  fUnderLoad = 32; // значение веса существенно меньше нуля
  fOverLoad = 64; // значение веса больше НПВ+9d
  fNoLoadCell = 128; // ошибка подключения (обрыв, повреждение) тензодатчика

// Последовательные порты
No_Com = 0;
Com_1 = 1;
Com_2 = 2;
Com_3 = 3;
Com_4 = 4;
Com_5 = 5;
Com_6 = 6;
Com_7 = 7;
Com_8 = 8;
// Скорости обмена
BaudRate_1200 = 0;
BaudRate_2400 = 1;
BaudRate_4800 = 2;
BaudRate_9600 = 3;
BaudRate_19200 = 4;
BaudRate_38400 = 5;
BaudRate_57600 = 6;
// Типы приборов
TypeDev_M06A = 0;
TypeDev_M06D = 1;
TypeDev_M06D6 = 2;
TypeDev_M06K = 3;
TypeDev_M1600 = 4;
TypeDev_M1900 = 5;
TypeDev_M2606 = 6;
TypeDev_Unknown = 255;
// Версии приборов
VersionDev_31X = 0;
VersionDev_32X = 1;
VersionDev_34X = 2;
VersionDev_35X = 3;
VersionDev_37X = 4;
VersionDev_41X = 5;
VersionDev_43X = 6;
VersionDev_49X = 7;
VersionDev_492 = 8;
VersionDev_50X = 9;
VersionDev_14X = 10;
VersionDev_2X = 11;
VersionDev_Unknown = 255;
// Переменные М06А
M06A_Brutto = 0;
M06A_Netto = 1;
M06A_Tare = 2;
M06A_Zero = 3;
M06A_ErrState = 4;
M06A_Flags0 = 5;
M06A_Flags1 = 6;
M06A_DState = 8;
M06A_SumTotal = 10;
M06A_SumCounter = 11;
M06A_SBrutto = 12;
M06A_ADC = 255;

// Константы М06А
M06A_TypeDev = 0;
M06A_VersionDev = 1;
M06A_MaxRange = 2;
M06A_PntPos = 3;
M06A_MaxBrutto = 4;
M06A_MaxBrutto0 = 4;
M06A_MaxBrutto1 = M06A_MaxBrutto0 + 1;
M06A_MaxBrutto2 = M06A_MaxBrutto0 + 2;
M06A_Discret = 7;
M06A_Discret0 = 7;
M06A_Discret1 = M06A_Discret0 + 1;
M06A_Discret2 = M06A_Discret0 + 2;
M06A_EEPROM_BlockCounter = 10;
M06A_EEPROM_ValidMask = 11;
M06A_EEPROM_CRC = 12;
M06A_EEPROM_CRC0 = 12;
M06A_EEPROM_CRC1 = M06A_EEPROM_CRC0 + 1;
M06A_EEPROM_CRC2 = M06A_EEPROM_CRC0 + 2;
M06A_EEPROM_CRC3 = M06A_EEPROM_CRC0 + 3;
M06A_EEPROM_CRC4 = M06A_EEPROM_CRC0 + 4;
M06A_EEPROM_CRC5 = M06A_EEPROM_CRC0 + 5;
M06A_EEPROM_CRC6 = M06A_EEPROM_CRC0 + 6;
M06A_EEPROM_CRC7 = M06A_EEPROM_CRC0 + 7;


type
  PPlatformRec = ^TPlatformRec;

  TPlatformRec = record
    PlatformNum: Byte;    // номер прибора
    TypeDev: Byte;        // тип прибора
    VersionDev: Byte;     // версия прибора
    Weight: Double;       // вес брутто платформы (М06А, М06Д, М06Д6),
                          // счетчик-интегратор (М06К),
                          // измеренная производительность (М1600)
    ClbZero: Double;      // вес «пустой» платформы,
                          // «рабочий» ноль (М06А, М06Д, М06Д6),
                          // мгновенная производительность или
                          // мгновенная лин. плотность (М06К),
                          // заданная производительность (М1600)
    PntPos: Byte;         // число знаков после запятой
    ErrState: Byte;       // код ошибки
    Flags0: Byte;         // бит-флаги состояния платформы
    Flags1: Byte;         // бит-флаги состояния прибора
    DFlags: Byte;         // бит-флаги состояния дозатора
    DState: Byte;         // состояние дозатора
  end;

implementation

end.
