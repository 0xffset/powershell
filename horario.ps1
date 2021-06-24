

<#Importing SQLite Path#>
 Add-Type -Path "C:\Program Files\System.Data.SQLite\2015\bin\System.Data.SQLite.dll"

 <# Getting connection#>
$connection = New-Object -TypeName System.Data.SQLite.SQLiteConnection
$connection.ConnectionString = "Data Source={put here you db path}"
$connection.Open()

function CreateTables() {
    $sqlCommand = $connection.CreateCommand()
    $sqlCommand.CommandText = "CREATE TABLE Assigments (
        Código VARCHAR(10) NOT NULL,
        Asignatura VARCHAR(20) NOT NULL,
        Modalidad VARCHAR(10) NOT NULL ,
        Dia VARCHAR(10) NOT NULL,
        Horario VARCHAR(50) NOT NULL
       )"
    $sqlAdapter = New-Object -TypeName System.Data.SQLite.SQLiteDataAdapter $sqlCommand
    $data = New-Object System.Data.DataSet
    [void]$sqlAdapter.Fill($data) 
    
}

function SelectAllRows() {
    $sqlCommand = $connection.CreateCommand()
    $sqlCommand.CommandText = "SELECT * FROM Assigments"
    $sqlAdapter = New-Object -TypeName System.Data.SQLite.SQLiteDataAdapter $sqlCommand
    $data = New-Object System.Data.DataSet
    [void]$sqlAdapter.Fill($data)
    $data.tables.rows
}

function RemoveTable() {
        $sql = $connection.CreateCommand()
        $sql.CommandText = "DROP TABLE Assigments"
        $sql.ExecuteNonQuery()
}

function InsertNewSubject($codigo, $asignatura, $modalidad, $dia, $horario) {

try {
 
        $sql = $connection.CreateCommand()
        $sql.CommandText = "INSERT INTO Assigments(Código, Asignatura, Modalidad, Dia, Horario) VALUES(@codigo, @asignatura, @modalidad, @dia, @horario)"
        $sql.Parameters.AddWithValue("@codigo", $codigo)
        $sql.Parameters.AddWithValue("@asignatura", $asignatura)
        $sql.Parameters.AddWithValue("@modalidad", $modalidad)
        $sql.Parameters.AddWithValue("@dia", $dia)
        $sql.Parameters.AddWithValue("@horario", $horario)
        $sql.ExecuteNonQuery()
        Write-Host "Materia insertada correctamente"
   
}
catch {
    "Error al insertar la asignatura."
}
}

function existsRow($codigo) {

   
    $sql = $connection.CreateCommand()
    $sql.CommandText = "SELECT Código FROM Assigments WHERE Código = @codigo"
    $sql.Parameters.AddWithValue("@codigo", $codigo)
    $sql.ExecuteNonQuery()
    $sqlAdapter = New-Object -TypeName System.Data.SQLite.SQLiteDataAdapter $sql
    $data = New-Object System.Data.DataSet
    [void]$sqlAdapter.Fill($data)
    $result = $data.Tables[0] | Select-Object -ExpandProperty "Código"
    $output =  If ($result.length -gt 0) {1} Else {0}
    return $output
  
} 

$header = @"

Autor: rolEYder


 ██████╗ █████╗ ██╗     ███████╗███╗   ██╗██████╗  █████╗ ██████╗ ██╗ ██████╗ 
██╔════╝██╔══██╗██║     ██╔════╝████╗  ██║██╔══██╗██╔══██╗██╔══██╗██║██╔═══██╗
██║     ███████║██║     █████╗  ██╔██╗ ██║██║  ██║███████║██████╔╝██║██║   ██║
██║     ██╔══██║██║     ██╔══╝  ██║╚██╗██║██║  ██║██╔══██║██╔══██╗██║██║   ██║
╚██████╗██║  ██║███████╗███████╗██║ ╚████║██████╔╝██║  ██║██║  ██║██║╚██████╔╝ v.1
 ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝ ╚═════╝ 
                                                                              

"@

function Show-Menu() {
 Clear-Host

<# Print the header#>
Write-Host $header -ForegroundColor green
Write-Host "=================[-] Menu [-]===================="
Write-Host "[1] Insertar Asignacion"
Write-Host "[2] Eliminar Asignacion"
Write-Host "[3] Modificar Asignatura"
Write-Host "[4] Ver Asignatura"
Write-Host "[5] Borrar todos las asignaturas"
Write-HOst "[6] Crear las tablas de las asignaturas"
Write-Host "[q] Salir"
Write-Host "====================================="
}


do
 {
    Show-Menu
    $selection = Read-Host "--> "
 
    switch ($selection)
    {
    '1' {
    
    $codigo = Read-Host "Ingrese el codigo de la materia"
    $asignatura = Read-Host "Ingrese el nombrde la asignatura"
    $modalidad = Read-Host "Ingrese la modalidad"
    $dia = Read-Host "Ingrese el dia"
    $horario = Read-Host "Ingrese el horario"

    InsertNewSubject "$codigo" "$asignatura"  "$modaliad"  "$dia"  "$horario"
    Write-Host $codigo $asignatura $modalidad $dia $horario

    } '2' {
    'You chose option #2'
    } '3' {
      'You chose option #3'
    } '4' {
       
        SelectAllRows
    } '5' {
        RemoveTable
        Write-Host "Tablas borradas..."
    }
        '6' {
            CreateTables
            Write-Host "Tablas creadas"
        }
    }
    pause
 }
 until ($selection -eq 'q')

