# RTGS: Real-Time 3D Gaussian Splatting SLAM via Multi-Level Redundancy Reduction

A real-time Gaussian Splatting implementation for SLAM systems, building upon the excellent work of MonoGS and Photo-SLAM.

## 📦 Installation

### 1. Clone the repository

```bash
git clone https://github.com/Nemo0412/MonoRTGS.git
cd MonoRTGS
```

### 2. Setup the environment

```bash
conda env create -f environment.yml
conda activate MonoRTGS
```

### 3. Downloading Datasets
The following scripts will automatically download datasets into the ./data folder.

#### TUM-RGBD Dataset
```bash
bash scripts/download_tum.sh
```

#### Replica Dataset
```bash
bash scripts/download_replica.sh
```

## 🚀 Usage

### SLAM Runner Script

This project includes convenient scripts to run both the original version (MonoGS) and RTGS version:

#### Python Script
```bash
python3 run_slam.py <version> <config>
```

#### Bash Script
```bash
./run_slam.sh <version> <config>
```

#### Examples
```bash
# Run original version
python3 run_slam.py original tum/fr3_office
./run_slam.sh original tum/fr3_office

# Run RTGS version
python3 run_slam.py RTGS tum/fr3_office
./run_slam.sh RTGS tum/fr3_office
```

### Supported Datasets

#### TUM Dataset
- `tum/fr1_desk`
- `tum/fr2_xyz`
- `tum/fr3_office`

#### Replica Dataset
- `replica/office0`
- `replica/office1`
- `replica/office2`
- `replica/office3`
- `replica/office4`
- `replica/room0`
- `replica/room1`
- `replica/room2`

## 📁 Project Structure

```
RTGS/
├── run_slam.py              # Python version SLAM runner script
├── run_slam.sh              # Bash version SLAM runner script
├── MonoGS/                  # Original version
├── MonoGS_RTGS/             # RTGS version
├── configs/                 # Configuration files
├── scripts/                 # Download scripts
└── data/                    # Dataset directory
```

## 🔗 Related Projects

### PhotoSLAM RTGS Implementation
For a RTGS-3DGS SLAM implementation based on Photo-SLAM, please check out:
- [PhotoSLAM RTGS Implementation](https://github.com/Nemo0412/PhotoRTGS.git)

## 🙏 Acknowledgements

This project builds upon the excellent work of the authors of **MonoGS** and **Photo-SLAM**.  
We gratefully acknowledge their open-source contributions, which make this project possible.

- [MonoGS (CVPR 2024)](https://github.com/muskie82/MonoGS.git)
- [Photo-SLAM (CVPR 2024)](https://github.com/HuajianUP/Photo-SLAM.git) 