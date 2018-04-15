rule deseq:
	input:
		config["folders"]["output_folder"] + "/{sample}.sam"
	output:
	conda: "../envs/hisat-deseq.yaml"
	script:
		"deseq2.R"
