function ber=ber_QAM(EbN0dB,M,AWGN_or_Rayleigh)
% Find analytical BER of M-ary QAM in AWGN or Rayleigh channel
% EbN0dB=EbN0dB: Energy per bit-to-noise power[dB] for AWGN channel
% =rdB : Average SNR(2*sigma Eb/N0)[dB] for Rayleigh channel
% M = Modulation order (Alphabet or Constellation size)
N= length(EbN0dB); sqM= sqrt(M);
a= 2*(1-power(sqM,-1))/log2(sqM); b= 6*log2(sqM)/(M-1);
if nargin<3, AWGN_or_Rayleigh='AWGN'; end
if lower(AWGN_or_Rayleigh(1))=='a'
     ber = a*Q(sqrt(b*10.^(EbN0dB/10))); % ber=berawgn(EbN0dB,’QAM’,M) Eq.(4.25)
    else % diversity_order=1; ber=berfading(EbN0dB,’QAM’,M,diversity_order)
     rn=b*10.^(EbN0dB/10)/2; ber = 0.5*a*(1-sqrt(rn./(rn+1))); % Eq.(4.26)
end