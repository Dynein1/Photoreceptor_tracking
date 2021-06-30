# Photoreceptor_tracking

# Repeated nuclear translocations underlie photoreceptor positioning and lamination of the outer nuclear layer within the mammalian retina

This repository contains the Matlab package used for analysing and quantifying apico-basally directed photoreceptor nuclear motility in the developing mouse retina. Nuclear trajectory data need to have been previously generated, for instance using IMARIS software (Bitplane). The Matlab package will generate the following data output: average mean squared displacement (AvMSD), trajectory duration, z positional information, instantaneous velocity, instantaneous acceleration, nuclear trajectories exhibiting above threshold velocities (e.g. rapid apical nuclear translocation).


This code accompanies the paper:

### Aghaizu, N.D., Warre-Cornish, K.M., Robinson, M.R., Waldron, P.V., Maswood, R.N., Smith, A.J., Ali, R.R., Pearson, R.R. (2021). Repeated nuclear translocations underlie photoreceptor positioning and lamination of the outer nuclear layer within the mammalian retina. Cell Reports (in press)

Paper abstract:

> In development, almost all stratified neurons must migrate from their birthplace to the appropriate neural layer. Photoreceptors reside in the most apical layer    of the retina, near their place of birth. Whether photoreceptors require migratory events for fine-positioning and/or retention within this layer is not well        understood. Here we show that photoreceptor nuclei of the developing mouse retina cyclically exhibit rapid, dynein 1-dependent, translocation towards the apical      surface, before moving more slowly in the basal direction, likely due to passive displacement by neighbouring retinal nuclei. Attenuating dynein 1 function in rod      photoreceptors results in their ectopic basal displacement into the outer plexiform layer and inner nuclear layer. Synapse formation is also compromised in these       displaced cells. We propose that repeated, apically-directed nuclear translocation events are necessary to ensure retention of post-mitotic photoreceptors within the   emerging outer nuclear layer during retinogenesis, which is critical for correct neuronal lamination.


### Data preparation:

Nuclear tracking data should be arranged as per 'Example_data.xls'. Note that *xyzt* information is provided, but average MSD calculation within this code only requires *zt* information. The Matlab package is tailored towards an acquisition interval of 10min, but can be adjusted accordingly.


### Running the code:


### Contributors:
Nozie Dominic Aghaizu, Martha Rose Robinson, Matteo Carandini, Paul Vincent Waldron

