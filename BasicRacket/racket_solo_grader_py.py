# example: run this with "python grader_filename.py your_code_filename"
# this is an auto-generated file for general student testing

import sys
import subprocess
import os
from difflib import Differ
if __name__ == "__main__":
    fn = sys.argv[1]
    tmp_fn = "tmp.rkt"
    feedback_fn = "feedback.txt"
    run_cmd = "racket"
    tests = """

(define (round-n num place)
  (let ((power (expt 10 place)))
    (/ (round (* power num)) power)))
(sum-coins 1 1 1 1)
(round-n (degrees-to-radians 60) 3)
(sign 4)
(round-n (new-sin 60 'radians) 3)
"""
    tests_info = """1. 1 point. sum-coins function general test.
2. 1 point. degrees-to-radians function general test. Make sure to use the Racket literal for the value of pi.
3. 1 point. sign function general test.
4. 1 point. new-sin function general test.
"""
    correctoutput = """41
1.047
1
-0.305
"""
    grade = 0
    total_possible = 0
    with open(fn, "r") as f:
        with open(tmp_fn, "w") as w:
            w.write(f.read())
            w.write(tests)
    cmd = [run_cmd, fn]
    process = subprocess.Popen(cmd, stdout=subprocess.PIPE)
    studentoutput, err = process.communicate()
    comparison = "".join(Differ().compare(correctoutput.splitlines(1), studentoutput.splitlines(1)))
    error_line_nos = []
    extra_line_nos = []
    q_line_nos = []
    for count, i in enumerate(comparison.splitlines()):
        if "-" == i[0]:
            error_line_nos.append(count)
        elif "+" == i[0]:
            extra_line_nos.append(count)
        elif "?" == i[0]:
            q_line_nos.append(count)
    failed_tests_line_nos = []
    for x in error_line_nos:
        numextralines = len([y for y in extra_line_nos if y < x])
        numqlines = len([z for z in q_line_nos if z < x])
        failed_tests_line_nos.append(x - numextralines - numqlines)
    with open(feedback_fn, "w") as feedback_file:
        feedback_file.write("        Correct output:\n")
        feedback_file.write(str(correctoutput))
        feedback_file.write("\n        Your output:\n")
        feedback_file.write(str(studentoutput))
        feedback_file.write("\n        Failed tests:\n")
        for count, l in enumerate(tests_info.splitlines(1)):
            points = int(l.split()[1])
            if count in failed_tests_line_nos:
                total_possible += points
                feedback_file.write(l)
            else:
                total_possible += points
                grade += points
        feedback_file.write("\n        Grade:\n" + str(grade) + " out of " + str(total_possible))
    os.remove(tmp_fn)
    print("See feedback file: " + feedback_fn)
