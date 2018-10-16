package tools  
      
import (  
	"fmt"  
	"os"
	"os/exec"
	"strings"
)

func Shell_exec(cmd_text string) string{
	var text []byte
    var err error
    var cmd *exec.Cmd
    cmd = exec.Command(cmd_text)
    if text, err = cmd.Output(); err != nil {
        fmt.Println(err)
        os.Exit(1)
    }
	return strings.Trim(string(text), "\n")
}