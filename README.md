# MLproject_FaceRecognition1 written in MATLAB
Problem Statement
Implement the following classifiers for face recognition.
· ML estimation with Gaussian assumption followed by Bayes rule
· Nearest neighbor rule
· PCA followed by Bayes classifier and NN rule
· LDA followed by Bayes classifier and NN rule
Try different scenarios. For example, you can test the effects of expressions, illumination variations,
etc. You can vary the amount of training data and see how the classification accuracy varies. The list
can go on as you wish.
Programming language: Matlab or C (preferably Matlab).
Submit a report detailing the methods employed, experiments performed and results. Some guidelines
for writing the report.
1) Please be concise. Please do not write more than 5-6 pages of text (excluding figures).
2) No need of explaining ML estimation, Bayes rule, NN rule, PCA and LDA in detail.
3) Just concentrate on the experiments and discuss the results you have obtained.
Submission details for the code will follow shortly. You are NOT allowed to use any function that is not
a part of standard Matlab toolboxes.
Datasets
data.mat (2.307 Mb)
illumination.mat (20.918 Mb)
POSE.mat (12.949 Mb)
Please run experiments over at least ONE of the datasets. You are encouraged to experiment with as
many datasets as possible.
1. DATA.MAT: Cropped images of 200 subjects, 3 images each, each image of size 24x21. The
file data.mat has a variable ”face” of size (24x21x600). The images corresponding to the
person labeled n, n = {1, . . . , 200} can be indexed in Matlab as face(:,:,3*n-2), face(:,:,3*n-1)
and face(:,:,3*n). The first image is a neutral face, the second image is a face with facial
expression, and the third image has illumination variations.
2) POSE.MAT: Dataset that contains images with pose variation. 68 subjects under 13 different
poses.
3) ILLUMINATION.MAT: Dataset that contains images with illumination variation. 68 subjects
across 21 illuminations.
4) You can also try other datasets like YALE dataset (which has expression variations) and PIE
dataset.
Immaterial of which dataset is used, you should divide it into two disjoint sets, one for training and the
other for testing. Train models using the training set and report results by testing it on the test set.
References
1) FaceRecognitionSurvey_ZhaoChellappa.pdf (3.696 Mb)
2) M. Turk, A. Pentland, "Eigenfaces for recognition," Journal of Cognitive Neuroscience, vol.
3, pp 72-86, 1991.
3) P. Belhumeur, J. Hespanha, and D. Kriegman, "Eigenfaces vs. Fisherfaces: Recognition
Using Class Specific Linear Projection," IEEE Trans. PAMI, vol. 19, pp. 711-720, 1997.
4) K. Etemad and R. Chellappa, "Discriminant Analysis for Recognition of Human Face
Images," Journal of Optical Society of America A, pp. 1724-1733, 1997.
5) R. Chellappa, C. Wilson, and S. Sirohey, "Human and Machine Recognition of Faces: A
Survey," Proceedings of IEEE, vol. 83, pp. 705-740, 1995.
6) W. Zhao, R. Chellappa, A. Rosenfeld, and J. Phillips, "Face Recognition: A Literature
Survey," to appear ACM computing surveys, 2003.
