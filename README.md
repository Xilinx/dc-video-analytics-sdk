# AMD Video Analytics SDK (Data Center) Docs

Documentation is developed on the master branch. Currently, this is documentation for **v1.0**. 

All the source files (``.rst`` files) for documentation are developed inside ``sources/v1.0`` directory. 

All the html files are placed inside ``html/v1.0`` directory. 

**Current steps for creating HTML files**

- Ensure ``sphinx-build`` version

```
>>sphinx-build --version
sphinx-build 5.3.0
```

- Generate HTML files

```
>>cd sources/v1.0/
>>rm -rf v1.0
>>sphinx-build -a . v1.0
>>rm -rf ../../html/v1.0
>>mv v1.0 ../../html/.
```

---------------------------------------------------------------------------------


  MIT License

  Copyright (c) 2023 Advanced Micro Devices, Inc.

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.



