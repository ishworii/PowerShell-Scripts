$PasswordLength = Read-Host "Please enter the length of the password.."
$PasswordLength = [int]$PasswordLength
$lowercase = "abcdefghijklmnopqrstuvwxyz"
$uppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
$digits = "0123456789"
$specialCharacters = "!@#$%^&*()_-=+`~.,<>/?;:{}[]"

if ($PasswordLength -lt 4) {
    Write-Host "Please enter a password length of 4 or greater."
} else {
    $password = @(
        $lowercase.Substring((Get-Random -Minimum 0 -Maximum $lowercase.Length), 1)
        $uppercase.Substring((Get-Random -Minimum 0 -Maximum $uppercase.Length), 1)
        $digits.Substring((Get-Random -Minimum 0 -Maximum $digits.Length), 1)
        $specialCharacters.Substring((Get-Random -Minimum 0 -Maximum $specialCharacters.Length), 1)
    )

    for ($i = 4; $i -lt $PasswordLength; $i++) {
        $randCharType = Get-Random -Minimum 1 -Maximum 5
        switch ($randCharType) {
            1 {
                $password += $lowercase.Substring((Get-Random -Minimum 0 -Maximum $lowercase.Length), 1)
            }
            2 {
                $password += $uppercase.Substring((Get-Random -Minimum 0 -Maximum $uppercase.Length), 1)
            }
            3 {
                $password += $digits.Substring((Get-Random -Minimum 0 -Maximum $digits.Length), 1)
            }
            4 {
                $password += $specialCharacters.Substring((Get-Random -Minimum 0 -Maximum $specialCharacters.Length), 1)
            }
        }
    }

    $password = $password | Get-Random -Count $password.Length
    Write-Host "Your password is: $($password -join '')"
}
