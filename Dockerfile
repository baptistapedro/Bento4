FROM fuzzers/afl:2.52

RUN apt-get update
RUN apt install -y build-essential wget git clang cmake  automake autotools-dev  libtool zlib1g zlib1g-dev libexif-dev
RUN git clone https://github.com/axiomatic-systems/Bento4.git
WORKDIR /Bento4
RUN cmake -DCMAKE_C_COMPILER=afl-clang -DCMAKE_CXX_COMPILER=afl-clang++ .
RUN make
RUN mkdir /mp4Corpus
RUN cp ./Test/Data/*.mp4 /mp4Corpus/

# can add harnesses for other binaries
ENTRYPOINT ["afl-fuzz", "-i", "/mp4Corpus", "-o", "/Bento4Out"]
CMD  ["/Bento4/mp4info", "@@"]
