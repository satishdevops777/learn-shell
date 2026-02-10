# 🎨 Colour Codes and Syntax in Shell Scripting

In **shell scripting (especially Bash)**, colour codes are used to add colors and styles to terminal output. This is done using **ANSI escape sequences**.

---

## 1. What are ANSI Escape Codes?

ANSI escape codes are special character sequences that control:

- Text color
- Background color
- Text formatting (bold, underline, etc.)

### General Syntax
```bash
\e[<codes>m
echo -e "\e[31mHello World\e[0m"
```

- -e → Enables escape sequence interpretation
- \e[31m → Red text
- \e[0m → Reset formatting

- Foreground (Text) Colour Codes

  | Colour  | Code |   
  | ------- | ---- |
  | Black   | `30` |
  | Red     | `31` |
  | Green   | `32` |
  | Yellow  | `33` |
  | Blue    | `34` |
  | Magenta | `35` |
  | Cyan    | `36` |
  | White   | `37` |

```echo -e "\e[32mSuccess Message\e[0m"```

- Background Colour Codes: Background colours are obtained by adding 10 to foreground colour codes.
  | Colour  | Code |
  | ------- | ---- |
  | Black   | `40` |
  | Red     | `41` |
  | Green   | `42` |
  | Yellow  | `43` |
  | Blue    | `44` |
  | Magenta | `45` |
  | Cyan    | `46` |
  | White   | `47` |

```echo -e "\e[30;43mWarning Message\e[0m"```

- Text Style Codes
  | Style     | Code |
  | --------- | ---- |
  | Reset     | `0`  |
  | Bold      | `1`  |
  | Dim       | `2`  |
  | Underline | `4`  |
  | Blink     | `5`  |
  | Reverse   | `7`  |

```echo -e "\e[1;34mBold Blue Text\e[0m"```
```\e[style;text_colour;background_colourm\e[0m"```
```
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
RESET="\e[0m"

echo -e "${GREEN}Build successful${RESET}"
echo -e "${RED}Build failed${RESET}"
```

# 🔀 Redirectors in Shell Scripting

In **shell scripting**, **redirectors (I/O redirection)** control **where input comes from** and **where output goes**.  
By default, commands read input from the keyboard and write output to the terminal, but redirectors allow you to send data to and from **files, devices, or other commands**.

---

## 1️⃣ Standard File Descriptors (FDs)

Every running process has three default file descriptors:

| FD | Name | Description |
|----|------|-------------|
| `0` | stdin | Standard input (keyboard) |
| `1` | stdout | Standard output (terminal) |
| `2` | stderr | Standard error (terminal) |

Redirectors work by **reassigning these file descriptors**.

---

## 2️⃣ Output Redirection (`>` and `>>`)

### `>` → Redirect stdout (overwrite)
```bash
ls > files.txt
```

### `>>` → Redirect stdout (append)
```bash
ls >> files.txt
```

---

## 3️⃣ Input Redirection (`<`)

```bash
sort < names.txt
```

---

## 4️⃣ Error Redirection (`2>` and `2>>`)

```bash
ls invalid_file 2> error.txt
```

---

## 5️⃣ Redirect stdout and stderr Together

```bash
command > all_output.txt 2>&1
```

---

## 6️⃣ Discard Output (`/dev/null`)

```bash
command &> /dev/null
```

---

## 7️⃣ Here Documents (`<<`)

```bash
cat << EOF
Hello
EOF
```

---

## 8️⃣ Here Strings (`<<<`)

```bash
grep root <<< "root:x:0:0:/root:/bin/bash"
```

---

## 9️⃣ Custom File Descriptors

```bash
exec 3> output.txt
echo "Hello" >&3
exec 3>&-
```

---

## 10️⃣ Common Examples

```bash
./script.sh > script.log 2>&1
```

---

## Summary

Redirectors give you **full control over command input and output**, making shell scripts powerful and flexible.

# 🧰 Stream Line Editor — `sed`

**`sed` (Stream EDitor)** is a powerful, non-interactive text-processing tool used in shell scripting to **search, find, replace, insert, delete, and transform text** from files or input streams.

It works **line by line** on a stream (file, pipe, or stdin) and outputs the result to **stdout**.

---

## 1️⃣ Why use `sed`?

- Fast and lightweight  
- Ideal for automation & scripting  
- Works with pipes  
- No need to open files interactively  
- Widely available on Linux/Unix  

### Typical Uses
- Replace text in logs  
- Edit configuration files  
- Extract or delete lines  
- Format command output  

---

## 2️⃣ Basic Syntax

```bash
sed [options] 'command' file
```

Or with a pipe:
```bash
command | sed 'command'
```

---

## 3️⃣ How `sed` Works (Important Concept)

1. Reads one line at a time  
2. Stores it in the *pattern space*  
3. Applies the command  
4. Prints the result (unless suppressed)  
5. Moves to the next line  

---

## 4️⃣ Most Common `sed` Command — Substitute (`s`)

### Syntax
```bash
sed 's/pattern/replacement/flags' file
```

### Example
```bash
sed 's/Linux/UNIX/' file.txt
```
✔ Replaces the **first occurrence per line**

### Replace All Occurrences
```bash
sed 's/Linux/UNIX/g' file.txt
```

---

## 5️⃣ Printing vs Modifying Output

By default, `sed` **does not change the file** — it only prints output.

```bash
sed 's/error/ERROR/' log.txt
```

### Modify File In-Place
```bash
sed -i 's/error/ERROR/' log.txt
```

### Create Backup Before Editing
```bash
sed -i.bak 's/error/ERROR/' log.txt
```

---

## 6️⃣ Delete Lines (`d`)

### Delete a Specific Line
```bash
sed '5d' file.txt
```

### Delete a Range of Lines
```bash
sed '2,5d' file.txt
```

### Delete Matching Lines
```bash
sed '/error/d' file.txt
```

---

## 7️⃣ Print Specific Lines (`p`)

Use with `-n` (suppresses default printing).

### Print a Single Line
```bash
sed -n '3p' file.txt
```

### Print a Range
```bash
sed -n '2,5p' file.txt
```

### Print Matching Lines
```bash
sed -n '/root/p' /etc/passwd
```

---

## 8️⃣ Insert and Append Text

### Insert Before a Line (`i`)
```bash
sed '3i\Inserted line' file.txt
```

### Append After a Line (`a`)
```bash
sed '3a\Appended line' file.txt
```

---

## 9️⃣ Change Entire Line (`c`)

```bash
sed '3c\This line is replaced' file.txt
```

---

## 🔟 Multiple Commands

Using `;`
```bash
sed 's/foo/bar/g; s/old/new/g' file.txt
```

Using `-e`
```bash
sed -e 's/foo/bar/' -e 's/old/new/' file.txt
```

---

## 1️⃣1️⃣ Addressing (Where Commands Apply)

| Address | Meaning |
|-------|--------|
| `5` | Line 5 |
| `2,5` | Line range |
| `/pattern/` | Matching lines |
| `$` | Last line |

### Example
```bash
sed '/ERROR/s/fail/FAIL/' log.txt
```

---

## 1️⃣2️⃣ Using `sed` with Pipes

Remove header line:
```bash
ps aux | sed '1d'
```

Remove `%` symbol:
```bash
df -h | sed 's/%//g'
```

---

## 1️⃣3️⃣ Common Real-World Examples

Remove empty lines:
```bash
sed '/^$/d' file.txt
```

Remove comments:
```bash
sed '/^#/d' config.conf
```

Replace tabs with spaces:
```bash
sed 's/\t/ /g' file.txt
```

Add line numbers:
```bash
sed = file.txt | sed 'N;s/\n/ /'
```

---

## 1️⃣4️⃣ `sed` vs `awk`

| Feature | sed | awk |
|------|-----|-----|
| Line editing | ✅ | ❌ |
| Column-based | ❌ | ✅ |
| Simpler tasks | ✅ | ❌ |
| Complex logic | ❌ | ✅ |

---

## 📌 One-Line Summary

> `sed` is a **stream-based, non-interactive editor** used to modify and transform text efficiently in shell scripts.

---

⭐ Essential for **Linux**, **DevOps**, **CI/CD pipelines**, and **shell scripting interviews**

