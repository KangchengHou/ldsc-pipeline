# LD score regression (LDSC) analysis pipeline

## Install

### Install LDSC
```bash
git clone --recursive git@github.com:KangchengHou/ldsc-pipeline.git
cd ldsc-pipeline/ldsc
conda create -n ldsc python=2.7
python -m ensurepip
conda env update --file environment.yml --name ldsc --prune
source activate ldsc
```

## Format annotation files

```bash
python ldsc/make_annot.py \
    --bed-file DATA/Brain_DPC_H3K27ac.bed \
    --bimfile DATA/1000G.EUR.QC.22.bim \
    --annot-file DATA/Brain_DPC_H3K27ac.annot.gz
```

## Calculate LD scores for custom `.bed` files

```bash
python ldsc/ldsc.py \
    --bfile /path/to/reference/genotype/file \
    --l2 \
    --ld-wind-cm 1 \
    --annot /path/to/custom/annotation/file \
    --out /path/to/output/file
```


## Run LD score regression with LD scores
```bash
python ldsc.py \
    --h2 /path/to/sumstats/file \
    --ref-ld-chr /path/to/ldscores/file \
    --frqfile-chr /path/to/frq/file \
    --w-ld-chr /path/to/weights/file \
    --overlap-annot \
    --print-coefficients \
    --out /path/to/output/file
```

