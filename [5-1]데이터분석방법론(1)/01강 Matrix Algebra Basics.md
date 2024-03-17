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

<center>
<img src="https://latex.codecogs.com/svg.image?&space;tr(A)=\sum\limits_{i=1}^{n}a_{ii}">
</center>

- Some straightforward properties are

<center>
<img src="https://latex.codecogs.com/svg.image?tr(cA)=c\cdot&space;tr(A)"><br>
<img src="https://latex.codecogs.com/svg.image?tr(A')=tr(A)"><br>
<img src="https://latex.codecogs.com/svg.image?tr(A&plus;B)=tr(A)&plus;tr(B)"><br>
<img src="https://latex.codecogs.com/svg.image?tr(I_k)=K"><br>
<img src="https://latex.codecogs.com/svg.image?tr(AB)=tr(BA)">
</center>

### 2. Inverse(역행렬)

- A *n×n* matrix A has full rank, or is nonsingular, if there is no C≠0 such that AC=0. In this case there exists a unique matrix B such that <img src="https://latex.codecogs.com/svg.image?AB=BA=I_n">.
- This matrix is called the inverse of A and is denoted by <img src="https://latex.codecogs.com/svg.image?A^{-1}">.
- Some properties include
<center>
<img src="https://latex.codecogs.com/svg.image?AA^{-1}=A^{-1}A=I_k"><br>
<img src="https://latex.codecogs.com/svg.image?(A^{-1})'=(A')^{-1}"><br>
<img src="https://latex.codecogs.com/svg.image?(AC)^{-1}=C^{-1}A^{-1}"><br>
<img src="https://latex.codecogs.com/svg.image?(A+C)^{-1}=A^{-1}(A^{-1}+C^{-1})^{-1}C^{-1}"><br>
<img src="https://latex.codecogs.com/svg.image?A^{-1}-(A+C)^{-1}=A^{-1}(A^{-1}+C^{-1})A^{-1}">
</center>

- Also, if A is an orthogonal matrix, then <img src="https://latex.codecogs.com/svg.image?A^{-1}=A">

### 3. Determinant(행렬식)

- For a general *n×n* matrix <img src="https://latex.codecogs.com/svg.image?A=[a_{ij}]">, we can define the determinant as follows.
  - Let <img src="https://latex.codecogs.com/svg.image?\pi=(j_1,\cdots,j_n)"> denote a permutation of <img src="https://latex.codecogs.com/svg.image?\(1,\cdots,n)">.
- There are n! such permutations. There is a unique count of the number of inversions of the indices of such permutations (relative to the natural order <img src="https://latex.codecogs.com/svg.image?\(1,\cdots,n)">), and let <img src="https://latex.codecogs.com/svg.image?\varepsilon_{\pi}=+1"> if this count is even and <img src="https://latex.codecogs.com/svg.image?\varepsilon_{\pi}=-1"> if the count is odd.
- Then
<center>
<img src="https://latex.codecogs.com/svg.image?Det&space;A=\sum\limits_{\pi}\varepsilon_{\pi}a_{1j_1}a_{2j_2}\cdots&space;a_{nj_n}">
</center>

- Examples) For a 3×3 matrix <img src="https://latex.codecogs.com/svg.image?A=[a_{ij}]">,

<center>
<img src="https://latex.codecogs.com/svg.image?\begin{pmatrix}a_{11}&a_{12}&a_{13}\\a_{21}&a_{22}&a_{23}\\a_{31}&a_{32}&a_{33}\\\end{pmatrix}"><br>

permutation &nbsp;&nbsp;&nbsp;&nbsp; <img src="https://latex.codecogs.com/svg.image?\varepsilon_{\pi}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; product(to be summed)
<img src="https://latex.codecogs.com/svg.image?\left\{ 1,2,3 \right\}\;\;\;\;\;\;0\;\;\;\;\;\;\;\;\;\;\;\;\;\;\;+a_{11}a_{22}a_{33}">
<img src="https://latex.codecogs.com/svg.image?\left\{ 1,3,2 \right\}\;\;\;\;\;\;1\;\;\;\;\;\;\;\;\;\;\;\;\;\;\;-a_{11}a_{23}a_{32}">
<img src="https://latex.codecogs.com/svg.image?\left\{ 1,2,3 \right\}\;\;\;\;\;\;1\;\;\;\;\;\;\;\;\;\;\;\;\;\;\;-a_{12}a_{21}a_{33}">
<img src="https://latex.codecogs.com/svg.image?\left\{ 1,2,3 \right\}\;\;\;\;\;\;2\;\;\;\;\;\;\;\;\;\;\;\;\;\;\;+a_{12}a_{23}a_{31}">
<img src="https://latex.codecogs.com/svg.image?\left\{ 1,2,3 \right\}\;\;\;\;\;\;2\;\;\;\;\;\;\;\;\;\;\;\;\;\;\;+a_{13}a_{21}a_{32}">
<img src="https://latex.codecogs.com/svg.image?\left\{ 1,2,3 \right\}\;\;\;\;\;\;1\;\;\;\;\;\;\;\;\;\;\;\;\;\;\;-a_{13}a_{22}a_{31}"><br>
<img src="https://latex.codecogs.com/svg.image?Det&space;A=\sum\limits_{\pi}\varepsilon_{\pi}a_{1j_1}a_{2j_2}\cdots&space;a_{nj_n}">
</center>

- Some properties include
  - <img src="https://latex.codecogs.com/svg.image?det&space;A=det&space;A'">
  - <img src="https://latex.codecogs.com/svg.image?det(aA)=a^ndet&space;A">
  - <img src="https://latex.codecogs.com/svg.image?det(AB)=(det&space;A)(det&space;B)">
  - <img src="https://latex.codecogs.com/svg.image?det(A^{-1})=det(A)^{-1}">
  - <img src="https://latex.codecogs.com/svg.image?det\begin{bmatrix}A&B\\C&D\\\end{bmatrix}=det(A)det(D-CA^{-1}B)"> if det A is invertible.
  - <img src="https://latex.codecogs.com/svg.image?det\begin{bmatrix}A&B\\C&D\\\end{bmatrix}=det(D)det(A-BD^{-1}C)"> if det D is invertible.
  - <img src="https://latex.codecogs.com/svg.image?det&space;A\neq0"> if and only if A is nonsingular.
  - If A is triangular(upper or lower), then <img src="https://latex.codecogs.com/svg.image?det&space;A=\prod_{i=1}^{n}a_{ii}">
  - If A is orthogonal, then <img src="https://latex.codecogs.com/svg.image?det&space;A=\pm&space;1">

## 04 Matrix Calculus

### 1. Matrix Calculus

- <img src="https://latex.codecogs.com/svg.image?Let\vec{x}=(x_1,\cdots,x_n)\;be\;n\times&space;1\;and\;g(\vec{x})=g(x_1,\cdots,x_n):R^n\to&space;R.">
- The vector derivative(벡터미분) is

<center>
<img src="https://latex.codecogs.com/svg.image?\frac{\partial}{\partial\vec{x}}g(x)=\begin{pmatrix}\frac{\partial}{\partial{x_1}}g(x)\\\vdots\\\frac{\partial}{\partial{x_n}}g(x)\end{pmatrix}">
</center>

and
<center>
<img src="https://latex.codecogs.com/svg.image?\frac{\partial}{\partial\vec{x}'}g(x)=\begin{pmatrix}\frac{\partial}{\partial{x_1}}g(x)&\cdots&\frac{\partial}{\partial{x_n}}g(x)\\\end{pmatrix}">
</center>

- Some properties are now summarized.
  - <img src="https://latex.codecogs.com/svg.image?\frac{\partial}{\partial\vec{x}}(a'\vec{x})=\frac{\partial}{\partial\vec{x}}(\vec{x}'a)=a">
  - <img src="https://latex.codecogs.com/svg.image?\frac{\partial}{\partial\vec{x}}(A\vec{x})=A">
  - <img src="https://latex.codecogs.com/svg.image?\frac{\partial}{\partial\vec{x}}(\vec{x}'A\vec{x})=(A&plus;A')\vec{x}">
  - <img src="https://latex.codecogs.com/svg.image?\frac{\partial^2}{\partial\vec{x}\partial\vec{x}'}(\vec{x}'A\vec{x})=(A&plus;A')">

## 05 Some Features of Matrix

### 1. Eigenvalues and Eigenvectors(고유값과 고유벡터)

- For any *n×n* matrix A, the roots of the *n*th degree polynomial equation in λ,
<img src="https://latex.codecogs.com/svg.image?det(\lambda&space;I-A)=\left|\lambda&space;I-A\right|=0">, denoted by <img src="https://latex.codecogs.com/svg.image?\lambda&space;_1,\lambda&space;_2,\cdots,\lambda&space;_n">, are called the ***eigenvalues*** of the matrix A.

- *n×n*인 행렬 A에 대해, 람다(λ)의 n차 다항식 <img src="https://latex.codecogs.com/svg.image?det(\lambda&space;I-A)=\left|\lambda&space;I-A\right|=0"> 의 근을 <img src="https://latex.codecogs.com/svg.image?\lambda&space;_1,\lambda&space;_2,\cdots,\lambda&space;_n"> 라고 표시하고, 행렬 A의 ***고유값***이라고 부른다.

- Any nonzero *n×1* vector <img src="https://latex.codecogs.com/svg.image?&space;x_i\neq&space;0"> such that <img src="https://latex.codecogs.com/svg.image?Ax_i=\lambda&space;_i&space;x_i"> is called an *eigenvector* of A corresponding to the eigenvalue <img src="https://latex.codecogs.com/svg.image?\lambda&space;_i">

- <img src="https://latex.codecogs.com/svg.image?&space;x_i\neq&space;0"> 일 때, <img src="https://latex.codecogs.com/svg.image?Ax_i=\lambda&space;_i&space;x_i"> 를 만족하는 *n×1* vector를 행렬 A의 고유벡터라고 부른다. 고유벡터는 행렬의 A의 고유값에 대응하는 벡터이다.

- It follows that A is nonsingular(i.e., <img src="https://latex.codecogs.com/svg.image?A^{-1}"> exists) if and only if A has no eigenvalues equal to zero(since a zero eigenvalue would imply that <img src="https://latex.codecogs.com/svg.image?\left|A\right|=0">).

- 이것은 A가 비특이(nonsingular)할 때 성립한다.
  - 행렬이 비특이하다는 것은 "행렬의 역행렬이 존재한다" 또는 "행렬의 열들이 선형독립이다" 또는 "행렬의 행렬식(determinant)이 0이 아니다"는 의미이다.
- A가 0과 같은 고유값이 없는 경우에만 A가 비특이하다는 것을 의미이다.
  - 행렬 A의 고유값이 0이면 <img src="https://latex.codecogs.com/svg.image?\left|A\right|=0"> 이다.

### 2. Diagonalization of a Symmetric Matrix(대칭 행렬의 대각화)

- For any *n×n* symmetrix matrix A, that is, A'=A, there exists an orthogonal matrix P such that <img src="https://latex.codecogs.com/svg.image?P'AP=\Lambda=diag(\lambda_1,\cdots,\lambda_n)">, where the <img src="https://latex.codecogs.com/svg.image?\lambda_1"> are the eigenvalues of A.
- A'=A인 *n×n*인 대칭 행렬에 대해 <img src="https://latex.codecogs.com/svg.image?P'AP=\Lambda=diag(\lambda_1,\cdots,\lambda_n)">를 만족하는 직교행렬 P가 존재하면 <img src="https://latex.codecogs.com/svg.image?\lambda_i">는 행렬 A의 고유값들이다.
  - P가 직교행렬이라는 것은 <img src="https://latex.codecogs.com/svg.image?P'P=I">를 만족하는 것을 의미한다.
- The corresponding eigenvectors of A are the column vectors of the matrix P.
- 행렬 A의 대응하는 고유벡터는 행렬 P의 열벡터이다.

### 3. Quadratic Forms(이차형식)

- For an *n×n* constant (symmetric) matrix <img src="https://latex.codecogs.com/svg.image?A={a_{ij}}">, the quadratic function of n variables x, where <imgs src="https://latex.codecogs.com/svg.image?\vec&space;x=(x_1,\cdots,x_n)'"> denoted an *n×1* vector, defined by <img src="https://latex.codecogs.com/svg.image?Q(\vec&space;x)=\vec&space;x'A\vec&space;x=\sum_{i=1}^{n}\sum_{j=1}^{n}a_{ij}x_ix_j">, is called a *quadratic form* with matrix A.

- n×n인 상수(대칭) 행렬 A의 경우, n개 변수를 가지는 벡터 x의 이차함수는 행렬 A의 "이차형식"이라고 한다.
  - 행렬 A의 이차형식은 <img src="https://latex.codecogs.com/svg.image?Q(\vec&space;x)=\vec&space;x'A\vec&space;x=\sum_{i=1}^{n}\sum_{j=1}^{n}a_{ij}x_ix_j">로 표현한다.

### 4. Idempotent Matrices(멱등 행렬)

- An n×n matrix A is idempotent if <img src="https://latex.codecogs.com/svg.image?A^2=AA=A">.

- <img src="https://latex.codecogs.com/svg.image?A^2=AA=A">인 행렬 A는 멱등 행렬이다.

- The idempotent matrices that we will consider will also be symmetric matrices, and then the symmetric idempotent matrix A is also referred to as a projection matrix.
- 멱등 행렬이면서 대칭인 행렬은 투영행렬이라고도 합니다.

- The eigenvalues of an idempotent matrix are either zero or one, since <img src="https://latex.codecogs.com/svg.image?\lambda&space;x=Ax\equiv&space;A^2x=A(Ax)=A(\lambda&space;x)=\lambda^2x"> implies that <img src="https://latex.codecogs.com/svg.image?\lambda=\lambda^2"> so that λ=0 or 1.

- 멱등 행렬의 고유값은 0 또는 1이다.
  - 왜냐하면 <img src="https://latex.codecogs.com/svg.image?\lambda&space;x=Ax\equiv&space;A^2x=A(Ax)=A(\lambda&space;x)=\lambda^2x"> 이므로, <img src="https://latex.codecogs.com/svg.image?\lambda=\lambda^2"> 이고, 그러면 λ=0 or 1 이기 때문이다.