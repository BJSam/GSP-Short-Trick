


## 💡 Lab Link: [Create and Manage AlloyDB Instances: Challenge Lab - GSP395](https://www.cloudskillsboost.google/focuses/100853?parent=catalog)

## 🚀 Lab Solution [Watch Here](https://youtu.be/wp4DhdFv7bQ)

---

## 💡 [Open this link in new tab](https://console.cloud.google.com/alloydb/clusters?referrer=search&project=)


### 💡 Active your Cloud Shell & click (+) icon to launch 2nd Cloud Terminal

1. Export the **ZONE** Name correctly in **both Cloud Terminal**
```
export ZONE=
```

2. Run the below commands in your **First Cloud Terminal**
```
curl -LO raw.githubusercontent.com/Techcps/GSP-Short-Trick/master/Create%20and%20Manage%20AlloyDB%20Instances%3A%20Challenge%20Lab/techcps395.sh
sudo chmod +x techcps395.sh
./techcps395.sh
```

3. Switch back to **Second Cloud Terminal**

4. Connect **SSH** of **`alloydb-client`**
```
gcloud compute ssh alloydb-client --zone=$ZONE --project=$DEVSHELL_PROJECT_ID --quiet
```

3. **Replacing ALLOYDB_ADDRESS with the Private IP address of the AlloyDB instance**
```
export ALLOYDB=
```

4. Below commands **store the Private IP address of the AlloyDB instance on the AlloyDB client VM**
```
echo $ALLOYDB  > alloydbip.txt 
```

5. This commands launch the **PostgreSQL (psql) client**
```
psql -h $ALLOYDB -U postgres
```

> You will be prompted to provide the postgres user's password **(Change3Me)** which you entered when you created the cluster
R TABLE departments ADD PRIMARY KEY (department_id);

```
CREATE TABLE regions (
    region_id bigint NOT NULL,
    region_name varchar(25)
) ;
ALTER TABLE regions ADD PRIMARY KEY (region_id);
```

```
CREATE TABLE countries (
    country_id char(2) NOT NULL,
    country_name varchar(40),
    region_id bigint
) ;
ALTER TABLE countries ADD PRIMARY KEY (country_id);
```

```
CREATE TABLE departments (
    department_id smallint NOT NULL,
    department_name varchar(30),
    manager_id integer,
    location_id smallint
) ;
ALTER TABLE departments ADD PRIMARY KEY (department_id);
```

```
INSERT INTO regions VALUES ( 1, 'Europe' );
INSERT INTO regions VALUES ( 2, 'Americas' );
INSERT INTO regions VALUES ( 3, 'Asia' );
INSERT INTO regions VALUES ( 4, 'Middle East and Africa' );
```

```
INSERT INTO countries VALUES ('IT', 'Italy', 1 );
INSERT INTO countries VALUES ('JP', 'Japan', 3  );
INSERT INTO countries VALUES ('US', 'United States of America', 2  );
INSERT INTO countries VALUES ('CA', 'Canada', 2  );
INSERT INTO countries VALUES ('CN', 'China', 3  );
INSERT INTO countries VALUES ('IN', 'India', 3 );
INSERT INTO countries VALUES ('AU', 'Australia', 3  );
INSERT INTO countries VALUES ('ZW', 'Zimbabwe', 4  );
INSERT INTO countries VALUES ('SG', 'Singapore', 3 );
```

```
INSERT INTO departments VALUES (10, 'Administration', 200, 1700 );
INSERT INTO departments VALUES (20, 'Marketing', 201, 1800);
INSERT INTO departments VALUES (30, 'Purchasing', 114, 1700 );
INSERT INTO departments VALUES (40, 'Human Resources', 203, 2400);
INSERT INTO departments VALUES (50, 'Shipping', 121, 1500);
INSERT INTO departments VALUES (60, 'IT', 103, 1400);
```

### Congratulations, you're all done with the lab 😄

---

### 🌐 Join our Community

- **Join our [Discussion Group](https://t.me/Techcpschat)** <img src="https://github.com/user-attachments/assets/a4a4b767-151c-461d-bca1-da6d4c0cd68a" alt="icon" width="25" height="25">
- **Please like share & subscribe to [Techcps](https://www.youtube.com/@techcps)** <img src="https://github.com/user-attachments/assets/6ee41001-c795-467c-8d96-06b56c246b9c" alt="icon" width="25" height="25">
- **Join our [WhatsApp Community](https://whatsapp.com/channel/0029Va9nne147XeIFkXYv71A)** <img src="https://github.com/user-attachments/assets/aa10b8b2-5424-40bc-8911-7969f29f6dae" alt="icon" width="25" height="25">
- **Join our [Telegram Channel](https://t.me/Techcps)** <img src="https://github.com/user-attachments/assets/a4a4b767-151c-461d-bca1-da6d4c0cd68a" alt="icon" width="25" height="25">
- **Follow us on [LinkedIn](https://www.linkedin.com/company/techcps/)** <img src="https://github.com/user-attachments/assets/b9da471b-2f46-4d39-bea9-acdb3b3a23b0" alt="icon" width="25" height="25">

### Thanks for watching :)

