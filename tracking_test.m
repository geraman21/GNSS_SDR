preamble_bits = [1 -1 -1 -1 1 -1 1 1];
bits = [1 1 1 1 1 1 1 1];
% "Upsample" the preamble - make 20 vales per one bit. The preamble must be
% found with precision of a sample.
preamble_ms = kron(preamble_bits, ones(1, 20));
 caCode = generateCAcode(21);
        % Then make it possible to do early and late versions
        caCode = [caCode(1023) caCode caCode(1)];

codeFreq = 1.023e6;
blksize = 38192;
remCodePhase = 0;
remCarrPhase = 0;
samplingFreq = 38.192e6;
earlyLateSpc = 0.5;
codePhaseStep = codeFreq / samplingFreq;
carrFreq = 9547426.342;
time    = (0:blksize) ./ samplingFreq;

carrCos = cos(trigarg(1:blksize));
carrSin = sin(trigarg(1:blksize));
trigarg = ((carrFreq * 2.0 * pi) .* time) + remCarrPhase;

tcode       = (remCodePhase-earlyLateSpc) : ...
                          codePhaseStep : ...
                          ((blksize-1)*codePhaseStep+remCodePhase-earlyLateSpc);
tcode2      = ceil(tcode) + 1;
earlyCode   = caCode(tcode2);

% Define index into late code vector
tcode       = (remCodePhase+earlyLateSpc) : ...
              codePhaseStep : ...
              ((blksize-1)*codePhaseStep+remCodePhase+earlyLateSpc);
tcode2      = ceil(tcode) + 1;
lateCode    = caCode(tcode2);

% Define index into prompt code vector
tcode       = remCodePhase : ...
              codePhaseStep : ...
              ((blksize-1)*codePhaseStep+remCodePhase);
tcode2      = ceil(tcode) + 1;
promptCode  = caCode(tcode2);

a = xcorr(preamble_ms, bits);