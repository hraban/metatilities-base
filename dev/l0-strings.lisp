(in-package #:metatilities)

(defun string-starts-with (string prefix &key test)
  (setf test (or (and test (ensure-function test)) #'eql))
  (let ((mismatch (mismatch prefix string :test test)))
    (or (not mismatch) (= mismatch (length prefix)))))

(defun string-ends-with (string suffix &key test)
  (setf test (or (and test (ensure-function test)) #'eql))
  (let ((mm 0))
    (loop for end1 from (1- (length string)) downto 0
	 for end2 from (1- (length suffix)) downto 0
       while (funcall test (aref string end1) (aref suffix end2)) do
	 (incf mm))
    (= mm (length suffix))))


#| OR

(defun string-starts-with (string prefix &key ignore-case-p)
  (declare (type string string prefix))
  (let ((prelen (length prefix)))
    (when (<= prelen (length string))
      (if ignore-case-p
        (string-equal string prefix :end1 prelen)
        (string= string prefix :end1 prelen)))))

;; not cribbed from Wilbur --cas
(defun string-ends-with (string suffix &key ignore-case-p)
  (declare (type string string suffix))
  (let ((suflen (length suffix))
        (strlen (length string)))
    (when (< suflen (length string))
      (if ignore-case-p
        (string-equal string suffix :start1 (- strlen suflen))
        (string= string suffix :start1 (- strlen suflen))))))

|#