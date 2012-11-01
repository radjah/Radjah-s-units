object IVK_DM: TIVK_DM
  OldCreateOrder = False
  Height = 169
  Width = 367
  object connIVK_DB: TADOConnection
    ConnectionString = 'FILE NAME=E:\proj\stat\IVK_dataextractor\conn.udl'
    Mode = cmRead
    Provider = 'SQLNCLI10.1'
    Left = 232
    Top = 16
  end
  object tbTags: TADOTable
    Connection = connIVK_DB
    CursorType = ctStatic
    IndexFieldNames = 'Logging_Name'
    TableName = 'BS3_Analog_Table_Tags'
    Left = 152
    Top = 16
  end
  object tbTWX_GLOBAL: TADOTable
    Connection = connIVK_DB
    CursorType = ctStatic
    IndexFieldNames = 'Table_Name'
    TableName = 'TWX_GLOBAL'
    Left = 80
    Top = 16
  end
end
