package kr.bit.mapper;

import kr.bit.beans.Student;
import java.util.List;
import kr.bit.beans.Student;
import org.apache.ibatis.annotations.*;
import org.springframework.beans.factory.annotation.Autowired;


@Mapper
public interface StudentMapper {

    @Select("select i.id as info_id, name_id, name,place,school,dept " +
             "from info i " +
            "join name n on n.id = i.name_id " +
            "where n.id=#{id} ")
    public Student getStudentById(int id);


    @Update("update info set place=#{place},school=#{school},dept=#{dept} where name_id=#{id}")
    public void infoUpdate(Student student);

    @Update("update name set name=#{name} where id=#{id}")
    public void nameUpdate(Student student);

    @Delete("delete from name where id=#{id}")
    public void nameDelete(int id);

    @Delete("delete from info where id=#{id}")
    public void infoDelete(int id);

    @Insert("INSERT INTO name(name) VALUES(#{name})")
    @Options(useGeneratedKeys = true, keyProperty = "name_id")
    void saveName(Student student);

    @Insert("INSERT INTO info(name_id, place, school, dept) VALUES(#{name_id}, #{place}, #{school}, #{dept})")
    void saveInfo(Student student);

    @Select("SELECT n.id AS name_id, n.name, i.id AS info_id, i.place, i.school, i.dept FROM name n LEFT OUTER JOIN info i ON n.id = i.name_id ORDER BY name")
    List<Student> findAll();

    @Select("SELECT n.id AS name_id, n.name, i.id AS info_id, i.place, i.school, i.dept FROM name n LEFT OUTER JOIN info i ON n.id = i.name_id WHERE n.name LIKE '%${name}%' ORDER BY name")
    List<Student> findAllByName(@Param("name") String name);
}
