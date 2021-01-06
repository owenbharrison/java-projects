ArrayList<Epicycle> dft(ArrayList<Integer> f){
  ArrayList<Epicycle> res = new ArrayList<Epicycle>();
  int N = f.size();
  for(int k=0;k<N;k++){
    float re = 0;
    float im = 0;
    for(int n=0;n<N;n++){
      float phi = (PI*2*k*n)/N;
      re += f.get(n)*cos(phi+PI);
      im -= f.get(n)*sin(phi+PI);
    }
    re/=N;
    im/=N;
    float freq = k;
    float amp = sqrt(re*re+im*im);
    float phase = atan2(im, re);
    res.add(new Epicycle(re, im, freq, amp, phase));
  }
  return res;
}

class Epicycle{
  float re, im, freq, amp, phase;
  
  public Epicycle(float r, float i, float f, float a, float p){
    re = r;
    im = i;
    freq = f;
    amp = a;
    phase = p;
  }
}

PVector showEpicycles(int x, int y, float rot, ArrayList<Epicycle> epis){
  push();
  for(int i=0;i<epis.size();i++){
    float px = x;
    float py = y;
    Epicycle epi = epis.get(i);
    
    float freq = epi.freq;
    float radius = epi.amp;
    float phase = epi.phase;
    x += radius*cos(freq * time + phase + rot);
    y += radius*sin(freq * time + phase + rot);
    
    stroke(255, 100);
    noFill();
    ellipse(px, py, radius*2, radius*2);
    
    stroke(255);
    line(px, py, x, y);
  }
  pop();
  return new PVector(x, y);
}
