# -*-coding: utf-8 -*-
# vim: syntax=python expandtab tabstop=4
# ShortBred
# Aron Arzoomand 4/3 2020

singularity: "docker://biobakery/shortbred:0.9.3_dev_702e3ef"

SAMPLES = glob_wildcards("input_fasta/{sample}.2.fasta").sample
print(SAMPLES)


rule all:
    input:
        expand("output/{sample}.txt", sample=SAMPLES)


rule SB_Identify:
    input:
        Input_Prots="identify_input/input_prots.faa",
        Ref_Prots="identify_input/ref_prots.faa",
    output:
        markers="markers/ShortBRED_CARD_2017_markers.faa",
        temp_id=directory(temp("markers/tmp/identify")),
    conda:
        "envs/env.yml"
    envmodules:
       "bioinfo-tools"
       "usearch/11.0.667" 
    shell:
        """
        shortbred_identify.py \
        --goi {input.Input_Prots} \
        --ref {input.Ref_Prots} \
        --markers {output.markers} \
        --tmp {output.temp_id} \
        --usearch /domus/h1/aroarz/bin/usearch
        """

rule SB_Quantify:
    input:
        read1="input_fasta/{sample}.1.fasta",
        read2="input_fasta/{sample}.2.fasta",
        markers="markers/ShortBRED_CARD_2017_markers.faa",
    output:
        results="output/{sample}.txt",
        temp_qu=directory(temp("output/tmp/{sample}")),
    conda:
        "envs/env.yml"
    envmodules:
        "bioinfo-tools"
        "usearch/11.0.667"
        "python/2.7.9"
    shell:
        """
        shortbred_quantify.py \
        --markers {input.markers} \
        --wgs \
             {input.read1} \
             {input.read2} \
        --results {output.results} \
        --tmp {output.temp_qu} \
        --usearch /domus/h1/aroarz/bin/usearch
        """

