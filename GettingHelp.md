<img src="assets/img/dash.png" width=100>

## Finding Answers (in order of preference)

- Try to find an answer by searching the Web.
- Try to find an answer by reading the manual.
- Try to find an answer by reading a FAQ.
- Try to find an answer by inspection or experimentation.
- Try to find an answer by asking a skilled friend.
- If you're a programmer, try to find an answer by reading the source code.

---

## Asking Questions

- It’s important to let other people know that you’ve done all of the previous things already
- If the answer is in the documentation, the answer will be “Read the documentation”
  - one email round wasted

---

## Example: Error Messages

```r
> library(datasets)
> data(airquality)
> cor(airquality)
Error in cor(airquality) : missing observations in cov/cor
```

---

## Google is your friend

<img src="assets/img/google.png" height=500>

---

## Asking Questions

- What steps will reproduce the problem?
- What is the expected output?
- What do you see instead?
- What version of the product (e.g. R, packages, etc.) are you using?
- What operating system?
- Additional information

---

## Subject Headers

- Stupid: "Help! Can't fit linear model!"
- Smart: "R 3.0.2 lm() function produces seg fault with large data frame, Mac OS X 10.9.1"
- Smarter: "R 3.0.2 lm() function on Mac OS X 10.9.1 -- seg fault on large data frame"

---

## Do
- Describe the goal, not the step
- Be explicit about your question
- Do provide the minimum amount of information necessary (volume is not precision)
- Be courteous (it never hurts)
- Follow up with the solution (if found)

---

## Don't
- Claim that you’ve found a bug
- Grovel as a substitute for doing your homework
- Post homework questions on mailing lists (we’ve seen them all)
- Email multiple mailing lists at once
- Ask others to debug your broken code without giving a hint as to what sort of problem they should be searching for

---

(This talk inspired by Eric Raymond’s “How to ask questions the smart way”)
