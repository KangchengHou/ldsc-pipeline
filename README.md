# LD score regression (LDSC) analysis pipeline

## Install
```bash
# clone repository
git clone --recursive https://github.com/KangchengHou/ldsc-pipeline.git
# install ldsc conda environment
cd ldsc-pipeline/ldsc
conda create -n ldsc python=2.7
python -m ensurepip
conda env update --file environment.yml --name ldsc --prune
# activate ldsc conda environment (need to be activated EVERY TIME before running ldsc)
source activate ldsc
```

## Step 1: format annotation file (runtime = ~10 mins)
`LDSC-DATA/example/test.hg19.bed` contains an example of a custom `.bed` file. The annotation needs to be in hg19 coordinates.

```bash
for chrom in {1..22}; do
    python ldsc/make_annot.py \
        --bed-file LDSC-DATA/example/test.hg19.bed \
        --bimfile LDSC-DATA/1000G_EUR_Phase3_plink/1000G.EUR.QC.${chrom}.bim \
        --annot-file LDSC-DATA/example/test.${chrom}.annot.gz
done
```

## Step 2: calculate LD scores for custom `.bed` files (runtime = ~6 mins for single chromosome, ~60 mins for all chromosomes)

```bash
for chrom in {1..22}; do
    python ldsc/ldsc.py \
        --l2 \
        --bfile LDSC-DATA/1000G_EUR_Phase3_plink/1000G.EUR.QC.${chrom} \
        --ld-wind-cm 1 \
        --annot LDSC-DATA/example/test.${chrom}.annot.gz \
        --thin-annot \
        --out LDSC-DATA/example/test.${chrom} \
        --print-snps LDSC-DATA/listHM3.txt
done
```

## Step 3: run LD score regression with LD scores (runtime = ~5 mins)
```bash
trait="UKB_460K.disease_AID_ALL"
baseline="LDSC-DATA/baseline_v1.2/baseline."
annot="LDSC-DATA/example/test."

python ldsc/ldsc.py \
    --h2 LDSC-DATA/sumstats/${trait}.sumstats \
    --ref-ld-chr ${baseline},${annot} \
    --frqfile-chr LDSC-DATA/1000G_Phase3_frq/1000G.EUR.QC. \
    --w-ld-chr LDSC-DATA/1000G_Phase3_weights_hm3_no_MHC/weights.hm3_noMHC. \
    --overlap-annot \
    --print-coefficients \
    --out LDSC-DATA/example/${trait}
```
