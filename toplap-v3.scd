(
s.waitForBoot{
	s.meter(8,8);
	s.volume.gui;
	FreqScope.new;
}
)

Help.gui;

(
SynthDef(\chroma,{ | bus=0 |
	var in, fft, mfcc;
	in = InFeedback.ar(0);
	fft = FFT(LocalBuf(1024), in);
	mfcc = MFCC.kr(fft, 12);
	12 do: { |i|
		SendTrig.kr(Impulse.kr(2), i, mfcc[i])
	};
}).add;
)

x = Synth(\chroma)

x.free


(
o = OSCFunc({ arg msg, time;
	b = NetAddr.new("127.0.0.1", 5005);    // create the NetAddr
	b.sendMsg("/chroma", msg[2].asString, msg[3].asString);
},'/tr', s.addr);
)

o.free;


thisProcess.openUDPPort(7007);
thisProcess.openPorts; 

// start in the beginning of the session

(
t = OSCFunc( { |msg, time, addr, recvPort|
	var data, regex;
	try {
		data = clump(msg.asString.findRegexp("[0-9]+\.[0-9]+") collect: { |i| i[1] }, 4);    // 4 components
		data.postln;
	}{
		|error| \caught.postln; error.dump;
	};
	Ndef(\a).set(\a1, data[0][0].interpret, \a2, data[0][1].interpret, \a3, data[0][2].interpret, \a4, data[0][3].interpret);
	Ndef(\a).set(\aa1, data[1][0].interpret, \aa2, data[1][1].interpret, \aa3, data[1][2].interpret, \aa4, data[1][3].interpret);
}, '/components');
)

t.free;
//play{FreeVerb2.ar(b=RLPF.ar(Klank.ar(`[(1..82)],Impulse.ar(1),0),SinOsc.ar(122).range(10,3300)),b)/99}// #SuperCollider #sc140

// Hello !! Happy Birthday TOPLAP!!!

Ndef(\a).fadeTime_(23)

Ndef(\a, {FreeVerb2.ar(b=RLPF.ar(Klank.ar(`[(1..82)],Impulse.ar(1),0),SinOsc.ar(122).range(10,13300)),b)/99}).play

Ndef(\a, {|a1=1,aa1=1,aa2=1,aa3=1,aa4=1| FreeVerb2.ar(b=RLPF.ar(Klank.ar(`[(1..82)],Impulse.ar(1/a1),0),SinOsc.ar(aa1).range(10,3300)),b)/99}).play


Ndef(\a, {|a1=1,a4=1,aa1=1,aa2=1,aa3=1,aa4=1| FreeVerb2.ar(b=RLPF.ar(Klank.ar(`[(1..82)],Impulse.ar(1/a1),0,decayscale:a4),SinOsc.ar(aa1).range(10,3300)),b)/99}).play

Ndef(\a, {|a1=1,a4=1,aa1=1,aa2=1,aa3=1,aa4=1| FreeVerb2.ar(b=RLPF.ar(Klank.ar(`[(1..82)],Impulse.ar(1/a1),a4,decayscale:a4),SinOsc.ar(aa1).range(10,3300)),b)/99}).play


Ndef(\a, {|a1=1,a2=1,a4=1,aa1=1,aa2=1,aa3=1,aa4=1| FreeVerb2.ar(b=RLPF.ar(Klank.ar(`[(1..82)],Impulse.ar(1/a2),a4,decayscale:a4),SinOsc.ar(aa1).range(10,3300)),b)/99}).play


Ndef(\a).clear(211)
Ndef(\b).clear(211)
Ndef(\c).clear(211)


Happy 15th birthday TOPLAP!!!!!!!!!!!!!!!!!!!!!!!!!

(
p = OSCFunc( { |msg, time, addr, recvPort|
	var data, regex;
	data = clump(msg.asString.findRegexp("[0-9]+\.[0-9]+") collect: { |i| i[1] }, 4);    // 4 components
	data.postln;
	Ndef(\b).set(\b1, data[0][0].interpret, \b2, data[0][1].interpret, \b3, data[0][2].interpret, \b4, data[0][3].interpret);
	Ndef(\b).set(\bb1, data[1][0].interpret, \bb2, data[1][1].interpret, \bb3, data[1][2].interpret, \bb4, data[1][3].interpret);	
}, '/components');
)

p.free;
// play{a=SinOsc.ar(_);f=Stepper.ar(LFPulse.ar(53+(329*a.(Duty.ar(1,0,Dseq([5,5,5,7],inf))))));a.(334/f).tanh!2}// #sc140 #SuperCollider


Ndef(\b).fadeTime_(13)

Ndef(\b,{|bb1=1,bb2=1,bb3=2,bb4=3|a=SinOsc.ar(_);f=Stepper.ar(LFPulse.ar(23+(bb1*a.(Duty.ar([bb1,bb2,bb3,bb4]/50,0,Dseq([5,5,5,7],inf))))));a.(334+28*LFPulse.kr(11)/f).tanh!2}).play

Ndef(\b,{|b1=1,b2=1,b3=1,b4=1,bb1=1,bb2=1,bb3=2,bb4=3|a=SinOsc.ar(_);f=Stepper.ar(LFPulse.ar(23+(bb1*a.(Duty.ar([bb1,bb2,bb3,bb4]/50,0,Dseq([1/b1,1/b2,1/b3,1/b4],inf))))));a.(334+28*LFPulse.kr(11)/f).tanh!2}).play

Ndef(\b).fadeTime_(5)

Ndef(\b,{|bb1=1,bb2=1,bb3=2,bb4=3|a=SinOsc.ar(_);f=Stepper.ar(LFPulse.ar(23+(bb1*a.(Duty.ar([bb1,bb2,bb3,bb4]/50,0,Dseq([5,(bb1/bb4).round,5,7],inf))))));a.(334+28*LFPulse.kr(11)/f).tanh!2}).play

Ndef(\b).clear(29)

// Ndef(\b).clear(9)
(1..22).collect{|i| i.nthPrime}

Ndef(\b,{|bb1=1,bb2=1,bb3=2,bb4=3|a=SinOsc.ar(_);f=Stepper.ar(LFPulse.ar(23+(bb1*a.(Duty.ar([bb1,bb2,bb3,bb4]/50,0,Dseq([5,(bb1/bb4).round,5,7],inf))))));a.(1.5*334+28*LFPulse.kr(11)/f).tanh!2}).play

Ndef(\b,{|bb1=1,bb2=1,bb3=2,bb4=3|a=SinOsc.ar(_);f=Stepper.ar(LFPulse.ar(23+(bb1*a.(Duty.ar([bb1,bb2,bb3,bb4]/50,0,Dseq([5,(bb1/bb4).round,5,7],inf))))));a.(Duty.kr(1,0,Dseq([1,1,1,1.5],inf))*334+28*LFPulse.kr(11)/f).tanh!2}).play


Ndef(\b,{|bb1=1,bb2=1,bb3=2,bb4=3,b4=1,b1|a=SinOsc.ar(_);f=Stepper.ar(LFPulse.ar(23+(bb1*a.(Duty.ar([bb1,bb2,bb3,bb4]/50,0,Dseq([5,(bb1/bb4).round,5,(b1/b4).round],inf))))));a.(334+28*LFPulse.kr(11)/f).tanh!2}).play

// Duty.kr(1,0,Dseq([1,1,1,1.5],inf))

Ndef(\b,{|bb1=1,bb2=1,bb3=2,bb4=3,b4=1,b1|a=SinOsc.ar(_);f=Stepper.ar(LFPulse.ar(23+(bb1*a.(Duty.ar([bb1,bb2,bb3,bb4]/50,0,Dseq([5,(bb1/bb4).round,5,(b1/b4).round],inf))))));a.(Duty.kr(1,0,Dseq([1,1,1,1.5],inf))*334+28*LFPulse.kr(11)/f).tanh!2}).play

Ndef(\b,{|b1=1,b4=1,bb1=1,bb2=1,bb3=2,bb4=3|a=SinOsc.ar(_);f=Stepper.ar(LFPulse.ar(23+(bb1*a.(Duty.ar([bb1,bb2,bb3,bb4]/50,0,Dseq([5,(bb1/bb4).round,5,(b1/b4).round],inf))))));a.(1.5*334+28*LFPulse.kr(b4*bb1)/f).tanh!2}).play


Ndef(\b,{|bb1=1,bb2=1,bb3=2,bb4=3|a=SinOsc.ar(_);f=Stepper.ar(LFPulse.ar(bb1+(329*a.(Duty.ar(Dseq((5..16).collect{|i|i.nthPrime}/10,inf),0,Dseq([5,5,5,7],inf))))));a.(1.5*334+LFPulse.kr(Duty.kr(Dseq((11..13).collect{|i| i.nthPrime}/10,inf),0,Dseq([(bb1/bb2).round, (bb2/bb2).round, (bb1/bb3).round, (bb1/bb4).round],inf))).range(1,Stepper.kr(SinOsc.kr(11),0,200,500))/f).tanh!2}).play

Ndef(\b).clear(29)

// faster here
Ndef(\b,{|bb1=1,bb2=1,bb3=2,bb4=3|a=SinOsc.ar(_);f=Stepper.ar(LFPulse.ar(53+(329*a.(Duty.ar(Dseq((5..16).collect{|i|i.nthPrime}/10,inf),0,Dseq([(bb1/bb3).round,5,(bb1/bb4).round,7],inf))))),SinOsc.kr(5)*pi,LFPulse.kr(7).range(0,1));FreeVerb.ar(a.(1.5*334+LFPulse.kr(Duty.kr(Dseq((11..13).collect{|i|i.nthPrime}/10,inf),0,Dseq((10..16).collect{|i|i.nthPrime}/10,inf))).range(1,Stepper.kr(SinOsc.kr(11),0,200,500))/f),0.25,0.15).tanh!2}).play


Ndef(\b,{|bb1=1,bb2=1,bb3=2,bb4=3|a=SinOsc.ar(_);f=Stepper.ar(LFPulse.ar(23+(bb1*a.(Duty.ar([bb1,bb2,bb3,bb4]/50,0,Dseq([5,5,5,7],inf))))));FreeVerb.ar(a.(1.5*334+28*LFPulse.kr(11)/f),0.5+Line.kr(0.0,0.5,19,doneAction:2),0.4).tanh!2}).play

Ndef(\b).fadeTime_(25)

Ndef(\a).clear(9)
Ndef(\b).clear(1)


/////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////

(
q = OSCFunc( { |msg, time, addr, recvPort|
	var data, regex;
	data = clump(msg.asString.findRegexp("[0-9]+\.[0-9]+") collect: { |i| i[1] }, 4);    // 4 components
	data.postln;
	Ndef(\c).set(\c1, data[0][0].interpret, \c2, data[0][1].interpret, \c3, data[0][2].interpret, \c4, data[0][3].interpret);
	Ndef(\c).set(\cc1, data[1][0].interpret, \c2, data[1][1].interpret, \cc3, data[1][2].interpret, \cc4, data[1][3].interpret);	
}, '/components');
)


Ndef(\c).fadeTime_(5)

// init session -- liveset -- #002
Ndef(\c, { var a=SinOsc; Pan2.ar(GrainIn.ar(2,a.kr(11),1/2**8,Hilbert.ar(a.ar(13))),a.kr(12)) }).play

Ndef(\c).clear

Ndef(\c, { |c1=1,c2=1,c3=1,c4=1| var a=SinOsc; Pan2.ar(GrainIn.ar(2,a.kr(1/c4),1/2**8,Hilbert.ar(a.ar(13))),a.kr(12)) }).play

Ndef(\c, { |c1=1,c2=1,c3=1,c4=1| var a=SinOsc; Pan2.ar(GrainIn.ar(2,a.kr(1/c4),1/2**8,Hilbert.ar(a.ar(13))),a.kr(12)) }).play

Ndef(\c, { |c1=1,c2=1,c3=1,c4=1,cc4=1| var a=SinOsc; Pan2.ar(GrainIn.ar(2,a.kr(1/c4),1/2**8,Hilbert.ar(a.ar(c4*cc4)*a.ar(1/c2))),a.kr(12)) }).play

Ndef(\c, { |c1=1,c2=1,c3=1,c4=1,cc1=1,cc2=1,cc3=1,cc4=1| var a=SinOsc; FreeVerb.ar(RHPF.ar(Pan2.ar(GrainIn.ar(2,a.kr(cc1),1/2**(1+Stepper.kr(a.kr(cc1/cc4),0,6,9)),Hilbert.ar(a.ar(13/cc2)*a.ar(cc1/cc4))),a.kr(12*a.kr(2))), SinOsc.kr(10).range(120,330), rq:cc4/cc1), 0.3, 0.3, 0.2) }).play

Ndef(\c, { |c1=1,c2=1,c3=1,c4=1,cc1=1,cc2=1,cc3=1,cc4=1| var a=SinOsc; FreeVerb.ar(RHPF.ar(Pan2.ar(GrainIn.ar(2,a.kr(cc1),1/2**(1+Stepper.kr(a.kr(cc1/cc4),0,6,9)),Hilbert.ar(a.ar(13/cc2)*a.ar(cc1/cc4))),a.kr(12*a.kr(2))), SinOsc.kr(10).range(120,330), rq:cc4/cc1), 0.3, 0.3, 0.2) }).play


// slow main freq --> c1/c4  (if c4 > 1)
Ndef(\c, { |c1=1,c2=1,c3=1,c4=1| var a=SinOsc; FreeVerb.ar(RHPF.ar(Pan2.ar(GrainIn.ar(2,a.kr(c1/c4),1/2**(1+Stepper.kr(a.kr(c1*c4),0,6,9)),Hilbert.ar(a.ar(c1)*a.ar(c1/c4))),a.kr(12*a.kr(c2))), SinOsc.kr(10).range(120,330+(40*LFPulse.kr(1/c4))), rq:c4/c1), 0.3, 0.3, 0.2) }).play



//////////////////////////////= ============================
// add for cc > 150
Ndef(\c, { |cc1=1,cc2=1,cc3=1,cc4=1,c1| var a=SinOsc; Splay.ar([FreeVerb.ar(RHPF.ar(Pan2.ar(GrainIn.ar(2,a.kr(cc2),1/2**(1+Stepper.kr(a.kr(cc1*cc4),0,6,9)),Hilbert.ar(a.ar(cc1)*a.ar(cc1/cc4))),a.kr(12*a.kr(cc2))), SinOsc.kr(10).range(120,330+((330*0.1667)*LFPulse.kr(1/cc4))), rq:cc4/cc1), 0.3, 0.3, 0.2), FreeVerb.ar(HPF.ar(WhiteNoise.ar(1)*Pulse.ar(cc2,0.0001),2200),0.2,0.3,0.3)/9]) }).play


// add BD
Ndef(\c, { |cc1=1,cc2=1,cc3=1,cc4=1| var a=SinOsc; Splay.ar([FreeVerb.ar(RHPF.ar(Pan2.ar(GrainIn.ar(2,a.kr(cc2),1/2**(1+Stepper.kr(a.kr(cc1*cc4),0,6,9)),Hilbert.ar(a.ar(cc1)*a.ar(cc1/cc4))),a.kr(12*a.kr(cc2))), SinOsc.kr(10).range(120,330+((330*0.1667)*LFPulse.kr(1/cc4))), rq:cc4/cc1), 0.3, 0.3, 0.2), FreeVerb.ar(HPF.ar(WhiteNoise.ar(1)*Pulse.ar(cc2,0.0001),2200),0.2,0.3,0.3)/9, Compander.ar(Pan2.ar(SinOsc.ar(12*Pulse.ar(1,0.1))),0,0.2)/2]) }).play

/// increase main freq -- change BD
Ndef(\c, { |cc1=1,cc2=1,cc3=1,cc4=1| var a=SinOsc; Splay.ar([FreeVerb.ar(RHPF.ar(Pan2.ar(GrainIn.ar(2,a.kr(cc1),1/2**(2+Stepper.kr(a.kr(cc1*cc4),0,6,9)),Hilbert.ar(a.ar(cc1)*a.ar(cc1/cc4))),a.kr(12*a.kr(cc2))), SinOsc.kr(10).range(120,330+((330*0.1667)*LFPulse.kr(1/cc4))), rq:cc4/cc1), 0.3, 0.3, 0.2), FreeVerb.ar(HPF.ar(WhiteNoise.ar(1)*Pulse.ar(cc2,0.001),2200),0.2,0.3,0.3)/9, Compander.ar(Pan2.ar(SinOsc.ar(24*Pulse.ar(2,0.2))),0,0.2)/2]) }).play


/// increase main freq -- change BD higher freq
Ndef(\c, { |c1=1,c2=1,c3=1,cc1=1,cc2=1,cc3=1,cc4=1| var a=SinOsc; Splay.ar([FreeVerb.ar(RHPF.ar(Pan2.ar(GrainIn.ar(2,a.kr(cc1),1/2**(4+Stepper.kr(a.kr(cc1*cc4),0,6,9)),Hilbert.ar(a.ar(cc1)*a.ar(cc1/cc4))),a.kr(12*a.kr(cc2))), SinOsc.kr(1/c3).range(120,c1+((c2*0.1667*2)*LFPulse.kr(cc4))), rq:cc4/cc1), 0.3, 0.3, 0.2), FreeVerb.ar(HPF.ar(WhiteNoise.ar(1)*Pulse.ar(cc1/cc4,0.001),2200),0.2,0.3,0.3)/9, Compander.ar(Pan2.ar(SinOsc.ar(38*Pulse.ar(2,cc1/cc4))),0,0.2)/2]) }).play


Ndef(\c).clear(119)