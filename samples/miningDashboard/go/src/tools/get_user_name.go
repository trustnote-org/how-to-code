package tools

func Get_user_name() string{
	return Shell_exec("whoami")
}