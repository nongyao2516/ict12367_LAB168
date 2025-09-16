<template>
  <div class="container mt-4">
    <h2 class="mb-3">แสดงข้อมูลนักศึกษา</h2>
    
    <div class="mb-3">
      <a class="btn btn-primary" href="/add_student" role="button">Add+</a>
    </div>

    <!-- ตารางแสดงข้อมูลลูกค้า -->
  <table class="table table-bordered table-striped">
  <thead class="table-primary">
    <tr>
      <th>ID</th>
      <th>ชื่อ</th>
      <th>นามสกุล</th>
      <th>อีเมล</th>
      <th>เบอร์โทร</th>
    </tr>
  </thead>
  <tbody>
    <tr v-for="student in students" :key="student.student_id">
      <td>{{ student.student_id }}</td>
      <td>{{ student.first_name }}</td>
      <td>{{ student.last_name }}</td>
      <td>{{ student.email }}</td>
      <td>{{ student.phone }}</td>
    </tr>
  </tbody>
</table>
    <!-- Loading -->
    <div v-if="loading" class="text-center">
      <p>กำลังโหลดข้อมูล...</p>
    </div>

    <!-- Error -->
    <div v-if="error" class="alert alert-danger">
      {{ error }}
    </div>
  </div>
</template>

<script>
import { ref, onMounted } from "vue";

export default {
  name: "StudentList",
  setup() {
    const students = ref([]);
    const loading = ref(true);
    const error = ref(null);

    // ฟังก์ชันดึงข้อมูลจาก API ด้วย GET
    const fetchStudents = async () => {
      try {
        const response = await fetch("http://localhost/ict12367_lab168/php_api/show_student.php", {
          method: "GET",
          headers: {
            "Content-Type": "application/json"
          }
        });

        if (!response.ok) {
          throw new Error("ไม่สามารถดึงข้อมูลได้");
        }

        const result = await response.json();
        if (result.success) {
          students.value = result.data;
        } else {
          error.value = result.message;
        }

      } catch (err) {
        error.value = err.message;
      } finally {
        loading.value = false;
      }
    };

    onMounted(() => {
      fetchStudents();
    });

    return {
      students,
      loading,
      error
    };
  }
};
</script>
