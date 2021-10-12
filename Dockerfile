# 5.0 tag used Debian 10 (Buster)

FROM mcr.microsoft.com/dotnet/sdk:5.0

# Build libgdiplus 6.0.5 with pango.
# Debian Buster uses version 1.42.4 of Pango which should be compatible with libgdiplus 6.0.5 (between 1.40.14 and 1.43).

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libgif-dev \
    autoconf \
    libtool \
    automake \
    build-essential \
    gettext \
    libglib2.0-dev \
    libcairo2-dev \
    libtiff-dev \
    libexif-dev \
    libpango1.0-dev \
    git \
    ca-certificates

RUN git clone --depth 1 --branch 6.0.5 https://github.com/mono/libgdiplus.git

WORKDIR /libgdiplus
RUN ./autogen.sh --with-pango && make

RUN cp /libgdiplus/src/.libs/libgdiplus.so.0.0.0 /usr/local/lib
WORKDIR /usr/local/lib
RUN ln -s libgdiplus.so.0.0.0 libgdiplus.so && ln -s libgdiplus.so.0.0.0 libgdiplus.so.0 && ldconfig
WORKDIR /

COPY pango.csproj /pango/pango.csproj
COPY Program.cs /pango/Program.cs
WORKDIR /pango
ENTRYPOINT ["dotnet", "run"]
