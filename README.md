# MulleObjCExpatFoundation

#### 👴🏼 XML parser based on MulleObjCStandardFoundation and libexpat

This adds XML capability for property lists via categories to **NSPropertyListSerialization**.
It uses the expat library.


| Release Version                                       | Release Notes  | AI Documentation
|-------------------------------------------------------|----------------|---------------
| ![Mulle kybernetiK tag](https://img.shields.io/github/tag/MulleFoundation/MulleObjCExpatFoundation.svg) [![Build Status](https://github.com/MulleFoundation/MulleObjCExpatFoundation/workflows/CI/badge.svg)](//github.com/MulleFoundation/MulleObjCExpatFoundation/actions) | [RELEASENOTES](RELEASENOTES.md) | [DeepWiki for MulleObjCExpatFoundation](https://deepwiki.com/MulleFoundation/MulleObjCExpatFoundation)






## Requirements

|   Requirement         | Release Version  | Description
|-----------------------|------------------|---------------
| [expat](https://github.com/libexpat/libexpat) | ![Mulle kybernetiK tag](https://img.shields.io/github/tag/libexpat/libexpat.svg) [![Build Status](https://github.com/libexpat/libexpat/workflows/CI/badge.svg?branch=release)](https://github.com/libexpat/libexpat/actions/workflows/mulle-sde-ci.yml) | 
| [MulleFoundationBase](https://github.com/MulleFoundation/MulleFoundationBase) | ![Mulle kybernetiK tag](https://img.shields.io/github/tag/MulleFoundation/MulleFoundationBase.svg) [![Build Status](https://github.com/MulleFoundation/MulleFoundationBase/workflows/CI/badge.svg?branch=release)](https://github.com/MulleFoundation/MulleFoundationBase/actions/workflows/mulle-sde-ci.yml) | 🧱 MulleFoundationBase amalgamates Foundations projects
| [MulleBase64](https://github.com/MulleWeb/MulleBase64) | ![Mulle kybernetiK tag](https://img.shields.io/github/tag/MulleWeb/MulleBase64.svg) [![Build Status](https://github.com/MulleWeb/MulleBase64/workflows/CI/badge.svg?branch=release)](https://github.com/MulleWeb/MulleBase64/actions/workflows/mulle-sde-ci.yml) | 💬 Decode and encode NSData with base64
| [mulle-objc-list](https://github.com/mulle-objc/mulle-objc-list) | ![Mulle kybernetiK tag](https://img.shields.io/github/tag/mulle-objc/mulle-objc-list.svg) [![Build Status](https://github.com/mulle-objc/mulle-objc-list/workflows/CI/badge.svg?branch=release)](https://github.com/mulle-objc/mulle-objc-list/actions/workflows/mulle-sde-ci.yml) | 📒 Lists mulle-objc runtime information contained in executables.

### You are here

![Overview](overview.dot.svg)

## Add

Use [mulle-sde](//github.com/mulle-sde) to add MulleObjCExpatFoundation to your project:

``` sh
mulle-sde add github:MulleFoundation/MulleObjCExpatFoundation
```

## Install

Use [mulle-sde](//github.com/mulle-sde) to build and install MulleObjCExpatFoundation and all dependencies:

``` sh
mulle-sde install --prefix /usr/local \
   https://github.com/MulleFoundation/MulleObjCExpatFoundation/archive/latest.tar.gz
```

### Legacy Installation

Install the requirements:

| Requirements                                 | Description
|----------------------------------------------|-----------------------
| [expat](https://github.com/libexpat/libexpat)             | 
| [MulleFoundationBase](https://github.com/MulleFoundation/MulleFoundationBase)             | 🧱 MulleFoundationBase amalgamates Foundations projects
| [MulleBase64](https://github.com/MulleWeb/MulleBase64)             | 💬 Decode and encode NSData with base64
| [mulle-objc-list](https://github.com/mulle-objc/mulle-objc-list)             | 📒 Lists mulle-objc runtime information contained in executables.

Download the latest [tar](https://github.com/MulleFoundation/MulleObjCExpatFoundation/archive/refs/tags/latest.tar.gz) or [zip](https://github.com/MulleFoundation/MulleObjCExpatFoundation/archive/refs/tags/latest.zip) archive and unpack it.

Install **MulleObjCExpatFoundation** into `/usr/local` with [cmake](https://cmake.org):

``` sh
PREFIX_DIR="/usr/local"
cmake -B build                               \
      -DMULLE_SDK_PATH="${PREFIX_DIR}"       \
      -DCMAKE_INSTALL_PREFIX="${PREFIX_DIR}" \
      -DCMAKE_PREFIX_PATH="${PREFIX_DIR}"    \
      -DCMAKE_BUILD_TYPE=Release &&
cmake --build build --config Release &&
cmake --install build --config Release
```

## Author

[Nat!](https://mulle-kybernetik.com/weblog) for Mulle kybernetiK  


