#!/usr/bin/env python3
"""
SLAM Runner Script
Choose to run original version (MonoGS) or RTGS version (MonoGS_RTGS) SLAM program based on input parameters

Usage:
    python run_slam.py original tum/fr3_office
    python run_slam.py RTGS tum/fr3_office
"""

import sys
import os
import subprocess
import argparse
from pathlib import Path


def run_slam(version, config_path):
    """
    Run SLAM program
    
    Args:
        version (str): 'original' or 'RTGS'
        config_path (str): config file path, e.g. 'tum/fr3_office'
    """
    # Determine working directory
    if version.lower() == 'original':
        work_dir = Path('MonoGS')
        print(f"Running original version (MonoGS)")
    elif version.upper() == 'RTGS':
        work_dir = Path('MonoGS_RTGS')
        print(f"Running RTGS version (MonoGS_RTGS)")
    else:
        print(f"Error: Unsupported version '{version}'. Please use 'original' or 'RTGS'")
        return False
    
    # Check if directory exists
    if not work_dir.exists():
        print(f"Error: Directory '{work_dir}' does not exist")
        return False
    
    # Build complete config file path
    full_config_path = f"configs/rgbd/{config_path}.yaml"
    config_file = work_dir / full_config_path
    
    # Check if config file exists
    if not config_file.exists():
        print(f"Error: Config file '{config_file}' does not exist")
        return False
    
    # Build command
    cmd = [
        sys.executable,  # Use current Python interpreter
        'slam.py',
        '--config',
        full_config_path,
        '--eval'
    ]
    
    print(f"Working directory: {work_dir.absolute()}")
    print(f"Config file: {full_config_path}")
    print(f"Command: {' '.join(cmd)}")
    print("-" * 50)
    
    try:
        # Switch to working directory and execute command
        result = subprocess.run(
            cmd,
            cwd=work_dir,
            check=True,
            capture_output=False  # Show output in real-time
        )
        print(f"\nSLAM program execution completed, exit code: {result.returncode}")
        return True
    except subprocess.CalledProcessError as e:
        print(f"\nSLAM program execution failed, exit code: {e.returncode}")
        return False
    except KeyboardInterrupt:
        print(f"\nUser interrupted execution")
        return False
    except Exception as e:
        print(f"\nError occurred during execution: {e}")
        return False


def main():
    parser = argparse.ArgumentParser(
        description="Run SLAM program - supports original and RTGS versions",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python run_slam.py original tum/fr3_office
  python run_slam.py RTGS tum/fr3_office
  python run_slam.py original replica/office0
  python run_slam.py RTGS replica/office0
        """
    )
    
    parser.add_argument(
        'version',
        choices=['original', 'RTGS'],
        help='Choose version: original (MonoGS) or RTGS (MonoGS_RTGS)'
    )
    
    parser.add_argument(
        'config',
        help='Config file path (without .yaml extension), e.g.: tum/fr3_office, replica/office0'
    )
    
    args = parser.parse_args()
    
    # Run SLAM
    success = run_slam(args.version, args.config)
    
    if success:
        print("Program execution successful!")
    else:
        print("Program execution failed!")
        sys.exit(1)


if __name__ == "__main__":
    main() 