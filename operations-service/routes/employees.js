import dotenv from 'dotenv';
import express from 'express';
const router = express.Router();


dotenv.config()
const postgrestapiurl = process.env.POSTGREST_API_URL;

// Get total number of employees
router.get('/employees/count', async (req, res) => {
    try {
        // Fetch data from the external API
        const response = await fetch(`${postgrestapiurl}/employees`);
        // Check if the response is OK
        if (!response.ok) {
            throw new Error(`Failed to fetch employees: ${response.status} ${response.statusText}`);
        }

        // Parse the JSON response
        const employees = await response.json();
        // Ensure the data is an array
        if (Array.isArray(employees)) {
            // Calculate and return the count
            const count = employees.length;
            return res.json({ count });
        } else {
            // Handle unexpected response format
            return res.status(500).json({ error: 'Unexpected response format from the employee API' });
        }
    } catch (error) {
        // Handle errors (e.g., network issues, API failures)
        console.error('Error fetching employee data:', error.message);
        return res.status(500).json({ error: 'Failed to fetch employee data' });
    }
});

// Get count of employees per month based on hire date
router.get('/employees/count/monthly', async (req, res) => {
    try {
        // Query the PostgREST API
        const response = await fetch(`${postgrestapiurl}/employees`);

        if (!response.ok) {
            throw new Error(`PostgREST API request failed: ${response.status} ${response.statusText}`);
        }

        // Parse the response JSON
        const employees = await response.json();

        if (Array.isArray(employees)) {
            // Calculate and sort the monthly hire count
            const sortedMonthlyHireCount = getMonthlyHireCountSorted(employees);

            // Return the result
            return res.json(sortedMonthlyHireCount);
        } else {
            return res.status(500).json({ error: 'Unexpected response format: expected an array of employees' });
        }
    } catch (error) {
        console.error('Error querying PostgREST API:', error.message);
        return res.status(500).json({ error: 'Failed to fetch employee data' });
    }
});

// Get list of employees
router.get('/employees', async (req, res) => {
    try {
        // Query the PostgREST API
        const response = await fetch(`${postgrestapiurl}/employees`);

        if (!response.ok) {
            throw new Error(`PostgREST API request failed: ${response.status} ${response.statusText}`);
        }

        // Parse the response JSON
        const employees = await response.json();

        if (Array.isArray(employees)) {
            // Sort employees by last name
            const sortedEmployees = sortEmployeesByLastName(employees);

            // Return the sorted list
            return res.json(sortedEmployees);
        } else {
            return res.status(500).json({ error: 'Unexpected response format: expected an array of employees' });
        }
    } catch (error) {
        console.error('Error querying PostgREST API:', error.message);
        return res.status(500).json({ error: 'Failed to fetch and sort employee data' });
    }
});

// Get an employee by ID
router.get('/employees/:id', async (req, res) => {
    const { id } = req.params; // Extract the employee ID from the request URL

    try {
        // Query the PostgREST API for the specific employee by ID
        const response = await fetch(`${postgrestapiurl}/employees?employee_id=eq.${id}`);

        if (!response.ok) {
            throw new Error(`PostgREST API request failed: ${response.status} ${response.statusText}`);
        }

        // Parse the response JSON
        const employees = await response.json();

        if (employees.length === 0) {
            // No employee found with the given ID
            return res.status(404).json({ error: `No employee found with ID: ${id}` });
        }

        // Return the first employee (PostgREST returns an array even for a single match)
        return res.json(employees[0]);
    } catch (error) {
        console.error('Error querying PostgREST API:', error.message);
        return res.status(500).json({ error: 'Failed to fetch employee data' });
    }
});

// Get an employee by first name
router.get('/employees/name/:name', async (req, res) => {
    const { name } = req.params; // Extract the employee ID from the request URL

    try {
        // Query the PostgREST API for the specific employee by ID
        const response = await fetch(`${postgrestapiurl}/employees?first_name=eq.${name}`);

        if (!response.ok) {
            throw new Error(`PostgREST API request failed: ${response.status} ${response.statusText}`);
        }

        // Parse the response JSON
        const employees = await response.json();

        if (employees.length === 0) {
            // No employee found with the given ID
            return res.status(404).json({ error: `No employee found with First Name: ${name}` });
        }

        // Return the first employee (PostgREST returns an array even for a single match)
        return res.json(employees[0]);
    } catch (error) {
        console.error('Error querying PostgREST API:', error.message);
        return res.status(500).json({ error: 'Failed to fetch employee data' });
    }
});

// API endpoint to update an employee's salary by ID
router.patch('/employees/:id/salary', async (req, res) => {
    const { id } = req.params; // Extract the employee ID from the URL
    const { salary } = req.body; // Extract the new salary from the request body

    // Validate input
    if (!salary || typeof salary !== 'number' || salary <= 0) {
        return res.status(400).json({ error: 'Invalid salary. Please provide a positive number.' });
    }

    try {
        // Send a PATCH request to the PostgREST API to update the salary
        const response = await fetch(`${postgrestapiurl}/employees?employee_id=eq.${id}`, {
            method: 'PATCH',
            headers: {
                'Content-Type': 'application/json', // Indicate we're sending JSON data
                'Prefer': 'return=representation',
            },
            body: JSON.stringify({salary}), // Send the new salary in the body
        });

        if (!response.ok) {
            throw new Error(`PostgREST API request failed: ${response.status} ${response.statusText}`);
        }

        // Parse the response
        const result = await response.json();

        // Check if the employee was updated
        if (result.length === 0) {
            return res.status(404).json({ error: `No employee found with ID: ${id}` });
        }

        // Return a success message
        return res.json({ message: `Employee with ID ${id} updated successfully`, updatedEmployee: result });
    } catch (error) {
        console.error('Error updating employee salary:', error.message);
        return res.status(500).json({ error: 'Failed to update employee salary' });
    }
});

// API endpoint to create a new employee record
router.post('/employees', async (req, res) => {
    const { employee_id, first_name, last_name, email, phone, position, salary, hire_date, avatar_url } = req.body;

    // Validate input
    if (
        !first_name || !last_name || !email || !phone || !department || !salary || !hire_date || !avatar ||
        typeof salary !== 'number' ||
        salary <= 0
    ) {
        return res.status(400).json({ error: 'Invalid input. Please provide all required fields with valid data.' });
    }

    try {
        // Send a POST request to the PostgREST API to create the new employee
        const response = await fetch(`${postgrestapiurl}/employees`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                //'Prefer': 'return=representation', // Request the created record to be returned
            },
            body: JSON.stringify({
                employee_id,
                first_name,
                last_name,
                email,
                phone,
                position,
                salary,
                hire_date,
                avatar_url,
            }),
        });

        if (!response.ok) {
            throw new Error(`PostgREST API request failed: ${response.status} ${response.statusText}`);
        }

        // Parse the response JSON
        const newEmployee = await response.json();

        // Return the created employee record
        return res.status(201).json({
            message: 'Employee created successfully',
            employee: newEmployee[0], // PostgREST returns an array of created records
        });
    } catch (error) {
        console.error('Error creating employee record:', error.message);
        return res.status(500).json({ error: 'Failed to create employee record' });
    }
});




    // Helper function to group employees by hire month and sort by date
    function getMonthlyHireCountSorted(employees) {
        const monthlyCount = {};

        // Group employees by hire month
        employees.forEach((employee) => {
            if (employee.hire_date) {
                const hireDate = new Date(employee.hire_date);

                if (!isNaN(hireDate)) {
                    // Format the hire date as "YYYY-MM" for grouping
                    const yearMonth = `${hireDate.getFullYear()}-${String(hireDate.getMonth() + 1).padStart(2, '0')}`;
                    monthlyCount[yearMonth] = (monthlyCount[yearMonth] || 0) + 1;
                }
            }
        });

        // Convert the grouped data into a sorted array
        const sortedMonthlyCount = Object.entries(monthlyCount)
            .sort(([dateA], [dateB]) => new Date(dateA) - new Date(dateB)) // Sort by date
            .reduce((acc, [month, count]) => {
                acc[month] = count; // Convert back to an object
                return acc;
            }, {});

        return sortedMonthlyCount;
    }
    // Helper function to sort employees by last name
    function sortEmployeesByLastName(employees) {
        return employees.sort((a, b) => {
            const lastNameA = a.last_name?.toLowerCase() || '';
            const lastNameB = b.last_name?.toLowerCase() || '';

            if (lastNameA < lastNameB) return -1;
            if (lastNameA > lastNameB) return 1;
            return 0;
        });
    }

export default router;