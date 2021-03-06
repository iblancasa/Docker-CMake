# MIT License

# Copyright (c) 2019 Israel Blancas

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
FROM debian:buster-slim as builder
RUN apt update && \
    apt install -y --no-install-recommends \
        wget \
        build-essential \
        ca-certificates &&\
    mkdir /cmake && \
    wget \
    https://github.com/Kitware/CMake/releases/download/v3.13.3/cmake-3.13.3-Linux-x86_64.tar.gz \
    && \
    tar -xvzf cmake-3.13.3-Linux-x86_64.tar.gz \
        -C /cmake \
        --strip-components=1

FROM gcr.io/distroless/cc:af71326844a672decdbd6779e3d25db49ce2609028204af160d3248f2a729fa4 as base
COPY --from=builder /cmake /cmake
ENTRYPOINT ["/cmake/bin/cmake"]
