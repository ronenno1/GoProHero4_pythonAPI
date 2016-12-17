big_physical_data    = Results_pre.exp.big_physical;
small_physical_data  = Results_pre.exp.small_physical;
big_numerical_data   = Results_pre.exp.big_numerical;
small_numerical_data = Results_pre.exp.small_numerical;

res.big_physical.pre.cong = mean(big_physical_data.RT(big_physical_data.congruent==1));
res.big_physical.pre.incong = mean(big_physical_data.RT(big_physical_data.congruent==0));
res.big_physical.pre.effect = res.big_physical.pre.incong-res.big_physical.pre.cong;

res.small_physical.pre.cong = mean(small_physical_data.RT(small_physical_data.congruent==1));
res.small_physical.pre.incong = mean(small_physical_data.RT(small_physical_data.congruent==0));
res.small_physical.pre.effect = res.small_physical.pre.incong-res.small_physical.pre.cong;

res.big_numerical.pre.cong = mean(big_numerical_data.RT(big_numerical_data.congruent==1));
res.big_numerical.pre.incong = mean(big_numerical_data.RT(big_numerical_data.congruent==0));
res.big_numerical.pre.effect = res.big_numerical.pre.incong-res.big_numerical.pre.cong;

res.small_numerical.pre.cong = mean(small_numerical_data.RT(small_numerical_data.congruent==1));
res.small_numerical.pre.incong = mean(small_numerical_data.RT(small_numerical_data.congruent==0));
res.small_numerical.pre.effect = res.small_numerical.pre.incong-res.small_numerical.pre.cong;

big_physical_data    = Results_post.exp.big_physical;
small_physical_data  = Results_post.exp.small_physical;
big_numerical_data   = Results_post.exp.big_numerical;
small_numerical_data = Results_post.exp.small_numerical;

res.big_physical.post.cong = mean(big_physical_data.RT(big_physical_data.congruent==1));
res.big_physical.post.incong = mean(big_physical_data.RT(big_physical_data.congruent==0));
res.big_physical.post.effect = res.big_physical.post.incong-res.big_physical.post.cong;
res.big_physical.change = res.big_physical.post.effect - res.big_physical.pre.effect;

res.small_physical.post.cong = mean(small_physical_data.RT(small_physical_data.congruent==1));
res.small_physical.post.incong = mean(small_physical_data.RT(small_physical_data.congruent==0));
res.small_physical.post.effect = res.small_physical.post.incong-res.small_physical.post.cong;
res.small_physical.change = res.small_physical.post.effect - res.small_physical.pre.effect;

res.big_numerical.post.cong = mean(big_numerical_data.RT(big_numerical_data.congruent==1));
res.big_numerical.post.incong = mean(big_numerical_data.RT(big_numerical_data.congruent==0));
res.big_numerical.post.effect = res.big_numerical.post.incong-res.big_numerical.post.cong;
res.big_numerical.change = res.big_numerical.post.effect - res.big_numerical.pre.effect;

res.small_numerical.post.cong = mean(small_numerical_data.RT(small_numerical_data.congruent==1));
res.small_numerical.post.incong = mean(small_numerical_data.RT(small_numerical_data.congruent==0));
res.small_numerical.post.effect = res.small_numerical.post.incong-res.small_numerical.post.cong;
res.small_numerical.change = res.small_numerical.post.effect - res.small_numerical.pre.effect;


