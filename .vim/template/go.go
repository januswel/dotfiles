package main

import (
    "fmt"
    "os"
    "runtime"
)

func main() {
    fmt.Println("hello world")
    fmt.Println(os.Args)
    fmt.Println(len(os.Args))
    fmt.Println(runtime.GOOS)
}

func exeDir() (string, error) {
    dir, err := filepath.Abs(filepath.Dir(os.Args[0]))
    if err != nil {
        return "", err
    }
    return dir, nil
}

func exists(path string) bool {
    _, err := os.Stat(path);
    return !os.IsNotExist(err)
}

func envVars() map[string]string {
    items := make(map[string]string)
    for _, item := range os.Environ() {
        splits := strings.Split(item, "=")
        items[splits[0]] = splits[1]
    }
    return items
}

func execute() (string, error) {
    // search execution file
    _, err := exec.LookPath("git")
    if err != nil {
        return "", err
    }

    // command to execute
    cmd := exec.Command("git", "rev-parse", "--show-toplevel")

    stdoutpipe, err := cmd.StdoutPipe()
    if err != nil {
        return "", err
    }
    defer stdoutpipe.Close()

    err = cmd.Start()
    if err != nil {
        return "", err
    }

    stdout, err := ioutil.ReadAll(stdoutpipe)
    if err != nil {
        return "", err
    }

    err = cmd.Wait()
    if err != nil {
        return "", err
    }

    dir := strings.TrimRight(string(stdout[:len(stdout)]), "\n")

    return dir, nil
}
