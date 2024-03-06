# 01강 Matrix Algebra Basics

## 01 Basic Concepts

### 1. Scalar

- A scalar *α* is a single number.
- A vector *α* is a *n×1* list of numbers, typically arranged in a column.
<center>
<img src="https://latex.codecogs.com/svg.image?\alpha=\begin{pmatrix}a_1\\a_2\\\vdots\\a_n\\\end{pmatrix}">
</center>

### 2. Vector

- Equivalently, a vector *α* is an element of Euclidean k space,
  hence <img src="https://latex.codecogs.com/svg.image?\alpha\in&space;R^n"/> If n=1 then *α* is a scalar
- A matrix A is a n×k rectangular array of numbers, written as
<center>
<img src="https://latex.codecogs.com/svg.image?A=\begin{bmatrix}a_{11}&a_{12}&\cdots&a_{1k}\\a_{21}&a_{22}&\cdots&a_{2k}\\\vdots&\vdots&&\vdots\\a_{n1}&a_{n2}&\cdots&a_{nk}\\\end{bmatrix}">
</center>

### 3. Vector to Matrix

- By convention, <img src="https://latex.codecogs.com/svg.image?\alpha_{ij}"> refers to the i th row and j th column of matrix A.
- A matrix can be written as a set of column vectors or as a set of row vectors.

<center>
<img src="https://latex.codecogs.com/svg.image?a_i=\begin{bmatrix}a_{1i}\\a_{2i}\\\vdots\\a_{ni}\end{bmatrix}">
</center>
are column vectors and 
<center>
<img src="https://latex.codecogs.com/svg.image?a'_j=\begin{bmatrix}a_{j1}&a_{j2}&\cdots&a_{jk}\\\end{bmatrix}">
</center>
are row vectors

### 4. The Transpose of a Matrix(전치행렬)
- The transpose of a matrix, denoted *B = A'*, is obtained by flipping the matrix on its diagonal.
<center>
<img src="https://latex.codecogs.com/svg.image?&space;B=A'=\begin{bmatrix}a_{11}&a_{21}&\cdots&a_{n1}\\a_{12}&a_{22}&\cdots&a_{n2}\\\vdots&\vdots&&\vdots\\a_{1k}&a_{2k}&\cdots&a_{nk}\\\end{bmatrix}">
</center>

- Thus, <img src="https://latex.codecogs.com/svg.image?b_{ij}=a_{ji}"/> for all i and j. Note that if A is *n×k*, then A' is *k×n*.
- If *α* is n×1 vector, then *α'* is a 1×n row vector.

### 5. Square Matrix(정방행렬)

- A matrix is square if n=k, A square matrix is symmetric if A=A', which implies <img src="https://latex.codecogs.com/svg.image?a_{ij}=a_{ji}">.
- A square matrix is diagonal if the only non-zero elements appear on the diagonal, so that <img src="https://latex.codecogs.com/svg.image?a_{ij}=0"> if i ≠ j.
- A square matrix is upper(lower) diagonal if all elements below(above) the diagonal equal zero.

## 02 Matrix Multiplication

### 1. Matrix Multiplication(벡터의 곱)

- An alternative way to write the matrix product is to use matrix partitions.
- For example,

<center>
<img src="https://latex.codecogs.com/svg.image?\inline&space;AB=\begin{bmatrix}A_{11}&A_{12}\\A_{21}&A_{22}\\\end{bmatrix}\begin{bmatrix}B_{11}&B_{12}\\B_{21}&B_{22}\\\end{bmatrix}\\=\begin{bmatrix}A_{11}B_{11}&plus;A_{12}B_{21}&A_{11}B_{12}&plus;A_{12}B_{22}\\A_{21}B_{11}&plus;A_{22}B_{21}&A_{21}B_{12}&plus;A_{22}B_{22}\\\end{bmatrix}">  
</center>

- And

<center>
<img src="https://latex.codecogs.com/svg.image?\inline&space;AB=\begin{bmatrix}A_1&A_2&\cdots&A_k\\\end{bmatrix}\cdot\begin{bmatrix}B_1\\B_2\\\vdots\\B_k\end{bmatrix}\\=A_{1}B_{1}&plus;A_{2}B_{2}&plus;\cdots&plus;A_{k}B_{k}\\=\sum\limits_{j=1}^{k}A_{j}B_{j}">
</center>

### 2. Euclidean Norm(벡터의 크기)

- The Euclidean norm of an m×1 vector α is

<center>
<img src="https://latex.codecogs.com/svg.image?\inline&space;|a|=(a'a)^{1/2}=\left(\sum\limits_{i=1}^{m}a_i^2\right)^{1/2}">
</center>

- if A is m×n matrix, then its Euclidean norm is

<center>
<img src="https://latex.codecogs.com/svg.image?\inline&space;|a|=tr(A'A)^{1/2}=(vec(A)'vec(A))^{1/2}=\left(\sum\limits_{i=1}^{m}\sum\limits_{j=1}^{n}a_{ij}^2\right)^{1/2}">
</center>

<center>
<img src="https://latex.codecogs.com/svg.image?\inline&space;For&space;A=\begin{bmatrix}a&b\\c&d\\\end{bmatrix},vec(A)=\begin{pmatrix}a\\c\\b\\d\end{pmatrix}">
</center>

### 3. Identity Matrix(항등행렬)

- An important diagonal matrix is identity matrix, which has ones on the diagonal.
- A n×n identity matrix is denoted as

<center>
<img src="https://latex.codecogs.com/svg.image?\inline&space;I_n=\begin{bmatrix}1&0&\cdots&0\\0&1&\cdots&0\\\vdots&\vdots&&\vdots\\0&0&\cdots&1\\\end{bmatrix}">
</center>

- Important properties are that if A is n×k, then <img src="https://latex.codecogs.com/svg.image?\inline&space;AI_k=A\;\;and\;\;I_{n}A=A">.

### 4. Orthogonal(직교)

- We say that two vectors *a and b* are orthogonal if *a'b=0*.
- The columns of a n×k matrix A, k≤n, are said to be orthogonal if <img src="https://latex.codecogs.com/svg.image?\inline&space;A'A=I_{k}">.
- A square matrix A is called orthogonal if <img src="https://latex.codecogs.com/svg.image?\inline&space;A'A=I_{n}">

## 03 Trace, Inverse, Determinant

### 1. Trace(대각선 원소의 합)

- The trace of a n×n square matrix A is the sum of its diagonal elements



## 04 Matrix Calculus
## 05 Some Features of Matrix