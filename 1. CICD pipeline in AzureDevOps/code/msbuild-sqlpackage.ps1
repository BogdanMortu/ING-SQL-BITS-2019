#C:\Users\bogda\source\repos\Demo\src\Demo
msbuild /t:build Demo.sqlproj

SqlPackage.exe /Action:Publish /SourceFile:"Demo.dacpac" /TargetDatabaseName:Demo /TargetServerName:"DESKTOP-DT7RHCP\WIN10SQL17DEV"
