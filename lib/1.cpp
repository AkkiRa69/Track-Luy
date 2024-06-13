#include <iostream>
#include <string>

using namespace std;

const int MAX_STUDENTS = 100;

class Person {
    protected:
        int id;
        string name;
        char gender;
};

class Assignment {
    protected:
        float assignmentScore;
};

class Homework {
   protected:
        float homeworkScore;
};

class Classwork {
   protected:
        float classworkScore;
};

class Exam {
   protected:
        float math, cpp, phy;
        float avg; // avg = (math + cpp + phy) / 3
};

class Grade : private Person, private Assignment, private Homework, private Classwork, private Exam {
    public:
        float totalScore;
        char grade;
};

