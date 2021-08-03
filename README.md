# Photoreceptor_tracking

# Repeated nuclear translocations underlie photoreceptor positioning and lamination of the outer nuclear layer within the mammalian retina

This repository contains the Matlab package used for analysing and quantifying apico-basally directed photoreceptor nuclear motility in the developing mouse retina. Nuclear trajectory data need to have been previously generated, for instance using IMARIS software (Bitplane). The Matlab package will generate the following data output: average mean squared displacement (AvMSD), trajectory duration, z positional information, instantaneous velocity, instantaneous acceleration, nuclear trajectories exhibiting above threshold velocities (e.g. rapid apical nuclear translocation).


This package accompanies the paper:

### Aghaizu, N.D., Warre-Cornish, K.M., Robinson, M.R., Waldron, P.V., Maswood, R.N., Smith, A.J., Ali, R.R., Pearson, R.R. (2021). Repeated nuclear translocations underlie photoreceptor positioning and lamination of the outer nuclear layer within the mammalian retina. Cell Reports (in press)

Paper abstract:

> In development, almost all stratified neurons must migrate from their birthplace to the appropriate neural layer. Photoreceptors reside in the most apical layer    of the retina, near their place of birth. Whether photoreceptors require migratory events for fine-positioning and/or retention within this layer is not well        understood. Here we show that photoreceptor nuclei of the developing mouse retina cyclically exhibit rapid, dynein 1-dependent, translocation towards the apical      surface, before moving more slowly in the basal direction, likely due to passive displacement by neighbouring retinal nuclei. Attenuating dynein 1 function in rod      photoreceptors results in their ectopic basal displacement into the outer plexiform layer and inner nuclear layer. Synapse formation is also compromised in these       displaced cells. We propose that repeated, apically-directed nuclear translocation events are necessary to ensure retention of post-mitotic photoreceptors within the   emerging outer nuclear layer during retinogenesis, which is critical for correct neuronal lamination.




<p align="center">
  <img width="600" height="600" src="https://github.com/RPearsonLab/Photoreceptor_tracking/blob/main/Graphical_abstract.jpg">
</p>


### Data preparation:

Nuclear tracking data should be arranged as per 'Example_data.xls'. Note that *xyzt* information is provided in 'Example_data.xls', but average MSD calculation within this code only requires *zt* information. The Matlab package is tailored towards an acquisition interval of 10min, but can be adjusted accordingly.


### Running the code:

1. Run 'MSDforztrackingdata.m' to read-in trajectory data and to calculate AvMSD & standard error values. The range of trajectories to be analysed from source file (line 134) needs to be specified (e.g.: 1, 2, 3,..., n). User will be prompted to navigate to source trajectory file (.xls format) upon initiation of the script.

2. Run 'ztrajectory_gen.m' to convert array trajectory data into matrix 'ztrajectories'.

3. Run 'Trajectory_analysis.m' for further kinetic analyses (positional changes, instantaneous velocity, instantaneous acceleration, rapid apical translocations) of trajectory data generated in (1.) and (2.). Note that further instructions are provided to identify rapid apical translocations (jx) within trajectories (lines 96-109).

### Contributors:
Nozie Dominic Aghaizu, Martha Rose Robinson, Matteo Carandini, Paul Vincent Waldron, Rachael Alexandra Pearson




Use/modification of Matlab code/scripts contained herein is permitted but requires citation:

Aghaizu et al. (2021). Repeated nuclear translocations underlie photoreceptor positioning and lamination of the outer nuclear layer within the mammalian retina. Cell Reports, 36, 109461
