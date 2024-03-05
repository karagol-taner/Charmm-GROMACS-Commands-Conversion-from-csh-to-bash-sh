# Charmm - GROMACS Commands Conversion: From csh to bash/sh

This repository contains the bash/sh conversion of Charmm (Chemistry at HARvard Macromolecular Mechanics) GROMACS commands from csh (C Shell) scripting. Charmm is a widely used computational chemistry software suite, and transitioning its scripts to bash/sh allows for better compatibility and flexibility across different systems.

These commands are designed to be easily deployable on your High-Performance Computing (HPC) or other computing systems, with Ubuntu recommended for optimal usage.

## Usage
**1.** Before using the scripts, ensure you have the dos2unix converter installed. You can install it using the following command:

```
sudo apt install dos2unix
```

&nbsp;
&nbsp;
**2.** Navigate to the directory containing the script and execute the following commands for each script (e.g., start.sh):
```
dos2unix start.sh
```
```
chmod +x start.sh
```

&nbsp;
&nbsp;
**3.** Run the bash script:
- **Option 1:** Run directly
```
./start.sh
```

- **Option 2:** Run in the background:
```
nohup ./start.sh > start.log &
```

You can monitor the progress by tailing the log file:
  ```
  tail -f start.log
  ```
To view the entire log file:
  ```
  cat start.log
  ```
**4.** Repeat these steps for each .sh file as needed.

## Questions
If you have any questions or encounter any issues, feel free to reach out.

## License
This project is licensed under the GPL-3.0 License.
