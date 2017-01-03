use <sweep.scad>

module ribs1(){
  towerpath1 = [for (v=[0 : 2 : 180])
    ((v > 50) ?
      translation([0, 0, 10*v]) *
      scaling([1.7+0.5*cos(v-65) + 0.005*(v-50)*cos(1.0*(v-40)+90),
               1.7+0.5*cos(v-65) + 0.005*(v-50)*cos(1.0*(v-40)+90), 1]) :
      translation([0, 0, 10*v]) *
      scaling([1.7+0.5*cos(v-65),
               1.7+0.5*cos(v-65), 1]))];

  function my_ribs(r) = [for (i=[0:0.5:359.9])
    r * [cos(i), sin(i)]
    + (sin(26*i)>0 ?
    100*sin(26*i)*[cos(i),sin(i)] :
    [0,0])];

  sweep(my_ribs(400), towerpath1);
}
scale([1,1,1.2])
ribs1();

module ribs2(){
  towershape = concat([[0,0,0]],
      [for (v=[0 : 20 : 1100])
        [2*(106+37*sin((40+2.1*v*360/(2*1970)))),0.6*v/4+1.4*(pow(v+20,0.5) - pow(20,0.5)),0]]);

  path = [for (a=[0:0.5:359])
            rotation([90,0,a]) *
            translation([80,0,0]) *
            scaling([1+0.5*sin(a*26),10+2.1*sin(a*2), 1])];

  sweep(towershape, path, true);
}
scale([1,1,1.3])
rotate([0,0,360/52])
scale([2.02,2.02,0.44])
ribs2();
