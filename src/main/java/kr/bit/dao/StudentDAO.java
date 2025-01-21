package kr.bit.dao;

import kr.bit.beans.Student;
import kr.bit.mapper.StudentMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@Transactional
public class StudentDAO{

    @Autowired
    private StudentMapper studentMapper;

    public Student getStudentByName(String name) {
        return studentMapper.getStudentByName(name);
    }

    public Student updateStudent(String name, Student student) {
        Student existingStudent = studentMapper.getStudentByName(name);
        if (existingStudent == null) {
            return null;
        }

        student.setName_id(existingStudent.getName_id());
        student.setInfo_id(existingStudent.getInfo_id());


        studentMapper.studentUpdate(student);


        return studentMapper.getStudentByName(student.getName());
    }

    public boolean deleteStudent(String name) {
        try {
            Student student = studentMapper.getStudentByName(name);
            if (student == null) {
                return false;
            }

            studentMapper.studentDelete(name);
            return true;
        } catch (Exception e) {
            log.error("Error: " + name, e);
            return false;
        }
    }
}