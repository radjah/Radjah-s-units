program FlashTool;

uses
  windows, registry, classes, dialogs;

var
  Rlst: LongBool;
  javabin, javaparams: string;
  StartUpInfo: TStartUpInfo;
  ProcessInfo: TProcessInformation;
  Error, i: integer;
  RegObj: TRegistry;
  JavaSubKeys: TStringList;

begin
  try
    // Работа с реестром
    RegObj := TRegistry.Create;
    JavaSubKeys := TStringList.Create;
    RegObj.RootKey := HKEY_LOCAL_MACHINE;
    // RegObj.CurrentPath:='SOFTWARE\JavaSoft\Java Runtime Environment';
    RegObj.OpenKey('SOFTWARE\JavaSoft\Java Runtime Environment', false);
    RegObj.GetKeyNames(JavaSubKeys);
    // for i := 0 to JavaSubKeys.Count - 1 do
    // ShowMessage(JavaSubKeys.Strings[i]);
    if JavaSubKeys.Count = 0 then
      MessageBox(0, 'Похоже, что у вас не установленна JRE' + #10#13 +
        'Скачайте её с сайта http://www.java.com', 'Ошибка!',
        MB_OK or MB_ICONEXCLAMATION)
    else
    begin
      RegObj.OpenKey('SOFTWARE\JavaSoft\Java Runtime Environment\' +
        JavaSubKeys.Strings[0], false);
      javaparams := RegObj.GetDataAsString('JavaHome', false) +
        '\bin\javaw.exe -jar x10flasher.jar';
      // ShowMessage(RegObj.GetDataAsString('JavaHome', false));
      // ShowMessage(javaparams);
      FillChar(StartUpInfo, SizeOf(TStartUpInfo), 0);
      with StartUpInfo do
      begin
        cb := SizeOf(TStartUpInfo);
        dwFlags := STARTF_USESHOWWINDOW or STARTF_FORCEONFEEDBACK;
        wShowWindow := SW_SHOWNORMAL;
      end;
      javabin := '';
      Rlst := CreateProcess(nil, pchar(javaparams), nil, nil, false,
        NORMAL_PRIORITY_CLASS, nil, nil, StartUpInfo, ProcessInfo);
      if Rlst then
        with ProcessInfo do
        begin
          WaitForInputIdle(hProcess, INFINITE); // ждем завершения инициализации
          CloseHandle(hThread); // закрываем дескриптор процесса
          CloseHandle(hProcess); // закрываем дескриптор потока
        end
      else
        Error := GetLastError;
    end;
  except
    MessageBox(0, 'Ошибочка вышла', 'Ошибка!', MB_OK or MB_ICONERROR);
  end;

end.
