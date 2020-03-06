FROM ubuntu:latest
MAINTAINER jaryamsiv

RUN apt-get update -y
RUN apt-get install sudo locales -y

# Generate the locales.
RUN sudo locale-gen en_US en_US.UTF-8
RUN sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

#Installing some dependencies
RUN sudo apt-get install ocaml curl m4 make patch unzip bubblewrap wget -y
RUN sudo apt-get install libedit-dev -y

#install ghdl
RUN wget http://archive.ubuntu.com/ubuntu/pool/universe/g/gnat-4.8/gnat-4.8-base_4.8.2-8ubuntu3_amd64.deb
RUN sudo dpkg --install gnat-4.8-base_4.8.2-8ubuntu3_amd64.deb
RUN wget http://archive.ubuntu.com/ubuntu/pool/universe/g/gnat-4.8/libgnat-4.8_4.8.2-8ubuntu3_amd64.deb
RUN sudo dpkg --install libgnat-4.8_4.8.2-8ubuntu3_amd64.deb
RUN wget https://github.com/tgingold/ghdl/releases/download/v0.33/ghdl_0.33-1ubuntu1_amd64.deb
RUN sudo dpkg --install ghdl_0.33-1ubuntu1_amd64.deb

# installing opam from internet
RUN curl -sL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh > install.sh
RUN printf "\n" | sh install.sh
RUN opam --version

#install coq
RUN opam init --disable-sandboxing
RUN eval $(opam env)
RUN opam install opam-depext
RUN opam pin add coq 8.11.0 -y
RUN opam install coq
ENV PATH="/root/.opam/default/bin:${PATH}"
RUN coqc -v

#to be replaced by configure.sh
