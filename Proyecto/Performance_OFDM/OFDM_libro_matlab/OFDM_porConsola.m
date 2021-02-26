clear all
clc
close all

fprintf("Arranca script \n")
NgType_parametro = input('NgType=1/2 for cyclic prefix/zero padding: ');
Ch_parametro = input('Ch=0/1 for AWGN/multipath channel: ');
Nbps_parametro = input('Modulation order=2/4/6 for QPSK/16QAM/64QAM: ');
Nfft_parametro = input('FFT size (64,128,256): ');
Ng_parametro = input(' GI (Guard Interval) length (Ng=0 for no GI): ');
Nvc_parametro = input(' Nvc=0: no VC (virtual carrier) o Pilot Signal: ');
OFDM_basic_parametrizable
