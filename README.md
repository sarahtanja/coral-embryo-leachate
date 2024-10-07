# coral-embryo-leachate
This project is a single stressor experiment exploring the early embryonic development of Montipora capitata corals when exposed to PVC leachate. In this project we look at how PVC leachate affects both physical cells and gene expression of coral embryos during development from unfertilized egg to the early gastrulation phases. 

The project page [Embryonic development of Montipora capitata coral exposed to PVC leachate
An ecotoxicological assay of Montipora capitata coral embryo development and gene expression under increasing PVC leachate exposures](https://sarahtanja.github.io/quarto-blog/posts/projects/coral-leachate-heat.html) contains all of the open notebook posts related to this project. 

The [Bioinformatic Pipeline Roadmap](https://sarahtanja.github.io/quarto-blog/posts/projects/coral-embryo-leachate/bioinformatics-pipeline/pipeline-overview.html) walks through the coding workflow used to analyze RNA-seq data. 

sample_id naming convention: In summary, there are 10 full replicates fixed for microscopy and 15 full replicates for omics across 4 leachate levels: control, low, middle, high, & 3 levels of embryonic development: 4hpf, 9hpf, 14hpf. 

  (1-15): The preceding number for the sample_id is the replicate according to genetic cross.
  (C,L,M,H): The four levels of leachate exposure. C stands for control, 1.2um filtered seawater. L stands for 'low', 0.01mg/L PVC Leachate. M stands for 'mid', 0.1mg/L PVC Leachate. H stands for 'high', 1mg/L PVC Leacate. All leachate was prepared according to the [leachate preparaton & dilution protocol](https://sarahtanja.github.io/quarto-blog/posts/projects/anemone/leachate-protocol/leachate-protocol.html)
  (4,9,14): The three levels of embryonic development assessed: 4 stands for 4 hours post fertilization, where eggs should have fertilized and reaached initial cleavage. 9 stands for 9 hours post fertilization, where embryos should be developed to the prawn chip phase. 14 stands for 14 hours post fertilization, when embryos should be reaching early gastrulation. 
  (Z, F): The two 'destinies' for the samples... either "Z", which stands for fixed in 4% paraformaldehyde for later microscopy, or "F" which stands for frozen at -800C in DNA/RNA Shield for later RNA extraction. 
