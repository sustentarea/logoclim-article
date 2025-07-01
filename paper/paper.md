---
title: "LogoClim: WorldClim in NetLogo"
tags:
  - Agent-based modeling
  - Climate change
  - Climate data visualization
  - Climate model integration
  - Climate projections
  - Climate simulation
  - CMIP6
  - Complex systems
  - Complexity science
  - Data interoperability
  - Environmental sciences
  - Environmental simulation
  - Future climate scenarios
  - Geospatial analysis
  - Historical climate data
  - LevelSpace
  - Models
  - NetLogo
  - Parallel execution
  - R (programming language)
  - Raster data
  - Reproducible research
  - Shared socioeconomic pathways
  - Simulations
  - Spatial analysis
  - Spatial resolution
  - SSPs
  - Time series
  - WorldClim
authors:
  - given-names: Daniel
    surname: Vartanian
    orcid: 0000-0001-7782-759X
    affiliation: 1
    corresponding: true
  - given-names: Leandro
    surname: Garcia
    orcid: 0000-0001-5947-2617
    affiliation: 2
  - given-names: Aline Martins
    dropping-particle: de
    surname: Carvalho
    orcid: 0000-0002-4900-5609
    affiliation: 3
affiliations:
- name: School of Arts, Sciences, and Humanities, University of São Paulo, São Paulo, Brazil
  index: 1
- name: School of Medicine, Queen's University Belfast, Belfast, United Kingdom
  index: 2
- name: School of Public Health, University of São Paulo, São Paulo, Brazil
  index: 3
date:  1 July 2025
bibliography: paper.bib
---

<!-- %:::% paper begin %:::% -->
# Summary

`LogoClim` is a [NetLogo](https://ccl.northwestern.edu/netlogo/) model for simulating and visualizing global climate conditions. It allows researchers to integrate high-resolution climate data into agent-based models, supporting reproducible research in ecology, agriculture, environmental science, and other fields that rely on climate data integration.

The model utilizes raster data to represent climate variables such as temperature and precipitation over time. It incorporates historical data (1951-2024) and future climate projections (2021-2100) derived from global climate models under various Shared Socioeconomic Pathways ([SSPs](https://climatedata.ca/resource/understanding-shared-socio-economic-pathways-ssps/), @oneill2017). All climate inputs come from [WorldClim 2.1](https://worldclim.org/), a widely used source of high-resolution, interpolated climate datasets based on weather station observations worldwide [@fick2017a], available for academic and other non-commercial use.

`LogoClim` follows the FAIR Principles for Research Software ([FAIR4RS](https://fair-software.eu/); @barker2022) and is openly available on the [CoMSES Network](https://www.comses.net/) and [GitHub](https://github.com/sustentarea/logoclim). Figures \autoref{fig-logoclim-interface-1} and \autoref{fig-logoclim-interface-2} illustrate the model's interface and functionality.

![LogoClim Graphical User Interface — Brazil (Spatial resolution: 10 arc-seconds, approximately 340 km² at the equator).\label{fig-logoclim-interface-1}](images/logoclim-interface-bra-10m-hmwd.png){width=100%}

# Statement of need

The lack of reproducibility is a major concern in science [@baker2016], including in computational research [@peng2011]. This challenge is particularly relevant for agent-based models, which are used to simulate complex phenomena [@grimm2006a; @grimm2020]. One effective strategy to address this issue is the development of open, specialized tools that enhance transparency and promote standardization, and reusability among researchers [@ram2019; @barba2022]. This is why `LogoClim` was created.

The `LogoClim` model was developed for seamless integration with other models through NetLogo's LevelSpace extension [@hjorth2020], which enables parallel execution and data exchange between models. This integration capability makes it particularly valuable for agent-based simulations that incorporate climate data to study ecological, environmental, or social processes affected by climate conditions.

# Motivation

The model was originally developed as part of a project by the [Sustentarea](https://www.fsp.usp.br/sustentarea/) Research and Extension Center, aimed at evaluating the impact of climate change on the health and nutrition of Brazilian children under five years old [@carvalho2023a]. During development, however, we recognized that the model had broader potential beyond the scope of our initial study. `LogoClim` can now be used as a submodel within agent-based models designed to help researchers, policymakers, and practitioners explore the potential impacts of climate change across different contexts and geographical areas.

# How it works

`LogoClim` operates on a grid of patches, where each patch represents a geographical area and stores values for latitude, longitude, and selected climate variables. During the simulation, patches update their colors based on the data values. The results can be visualized on a map, accompanied by plots that display the mean, minimum, maximum, and standard deviation of the selected variable over time.

In addition to latitude and longitude data points, `LogoClim` supports simulation with all three climate data series provided by [WorldClim 2.1](https://worldclim.org/): long-term historical climate averages (1970-2000), historical monthly weather (1951-2024), and future climate projections (2021-2100). Each series is available at multiple spatial resolutions (from 10 minutes (~340 km² at the equator) to 30 seconds (~1 km² at the equator)) and can be selected within the model interface. More information about each series can be found on the WorldClim website.

While you can download the original datasets directly from WorldClim 2.1, they must first be converted to ASCII raster format before being used in NetLogo. To simplify this process, we recommend using the preprocessed datasets included in the model's [OSF repository](https://doi.org/10.17605/OSF.IO/RE95Z). We have already converted the data for many countries and resolutions, making it easier to get started. These datasets can be reproduced by running the [Quarto](https://quarto.org/) notebooks located in the model's `qmd` folder.

![LogoClim Graphical User Interface — United Kingdom (Spatial resolution: 30 arc-seconds, approximately 1 km² at the equator).\label{fig-logoclim-interface-1}](images/logoclim-interface-gbr-30s-hcd.png){width=100%}

# Acknowledgements

We gratefully acknowledge the contributions of [Stephen E. Fick](https://orcid.org/0000-0002-3548-6966), [Robert J. Hijmans](https://orcid.org/0000-0001-5872-2872), and the entire [WorldClim](https://worldclim.org/) team for their dedication to developing and maintaining the WorldClim datasets. We also thank the World Climate Research Programme ([WCRP](https://www.wcrp-climate.org/)), which, through its Working Group on Coupled Modelling, coordinated and promoted the Coupled Model Intercomparison Project Phase 6 ([CMIP6](https://pcmdi.llnl.gov/CMIP6/)).

We acknowledge the climate modeling groups for producing and sharing their outputs; the Earth System Grid Federation ([ESGF](https://esgf.llnl.gov/)) for archiving and facilitating access to the data; and the many funding agencies that support both CMIP6 and ESGF.

Finally, we acknowledge the [Sustentarea](https://www.fsp.usp.br/sustentarea/) Research and Extension Center at the University of São Paulo ([USP](https://www5.usp.br/)), the Department of Science and Technology of the Secretariat of Science, Technology, and Innovation and of the Health Economic-Industrial Complex ([SECTICS](https://www.gov.br/saude/pt-br/composicao/sectics)) of the [Ministry of Health](https://www.gov.br/saude/en) of Brazil, and the National Council for Scientific and Technological Development ([CNPq](https://www.gov.br/cnpq/)) (grant no. 444588/2023-0) for their support in the development of this project.

# Author contributions

The roles below were defined based on the Contributor Roles Taxonomy ([CRediT](https://credit.niso.org/)).

[**Daniel Vartanian**](https://orcid.org/0000-0001-7782-759X): Conceptualization, Methodology, Data curation, Software, Validation, Project administration, Writing – Review & editing.

[**Leandro Garcia**](https://orcid.org/0000-0001-5947-2617): Validation, Writing - Review & editing.

[**Aline Martins de Carvalho**](https://orcid.org/0000-0002-4900-5609): Conceptualization, Funding acquisition, Validation, Project administration, Supervision, Writing – Review & editing.

# Additional information

`LogoClim` is an independent project with no affiliation to [WorldClim](https://www.worldclim.org) or its developers. Users should be aware that WorldClim datasets are freely available for academic and other non-commercial use only. Any use of WorldClim data within `LogoClim` must comply with [WorldClim's licensing terms](https://www.worldclim.org/about.html).
<!-- %:::% paper end %:::% -->

# References
