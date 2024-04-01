from flask import Flask, render_template, request, redirect, url_for
import mysql.connector


app = Flask(__name__)


@app.route("/", methods=["GET", "POST"])
def index():
    return render_template("index.html")


@app.route("/table_select")
def table_select():
    return render_template("start.html")


@app.route("/table")
def table():
    conn = mysql.connector.connect(
        host="localhost", user="root", password="root", database="sunheri_kiran"
    )
    table_name = request.args.get("table_name")
    page = int(request.args.get("page", 1))
    rows_per_page = 10

    cursor = conn.cursor()

    cursor.execute(f"SELECT COUNT(*) FROM {table_name}")
    total_rows = cursor.fetchone()[0]

    offset = (page - 1) * rows_per_page

    cursor.execute(f"SELECT * FROM {table_name} LIMIT {rows_per_page} OFFSET {offset}")
    data = cursor.fetchall()
    temp_columns = cursor.description
    columns_data = [description[0] for description in temp_columns]

    cursor.close()
    cursor = conn.cursor()
    cursor.execute(f"DESC {table_name}")
    desc = cursor.fetchall()
    columns_desc = [description[0] for description in cursor.description]
    conn.close()

    return render_template(
        "table.html",
        data=data,
        desc=desc,
        columns_desc=columns_desc,
        columns_data=columns_data,
        table_name=table_name,
        page=page,
        total_rows=total_rows,
        rows_per_page=rows_per_page,
        placeholder="Enter your query here...",
    )


@app.route("/result", methods=["POST"])
def result():
    conn = mysql.connector.connect(
        host="localhost", user="root", password="root", database="sunheri_kiran"
    )
    query = request.form.get("query")
    table_name = request.form.get("table_name")

    cursor = conn.cursor(buffered=True)
    try:
        if (
            "create" in query.lower()
            or "insert" in query.lower()
            or "delete" in query.lower()
        ):
            conn.commit()
            cursor.execute(f"SELECT * FROM {table_name}")
            data = cursor.fetchall()
        else:
            cursor.execute(query)
            data = cursor.fetchall()

    except mysql.connector.Error:
        conn.close()
        return redirect(url_for("table", table_name=table_name, page=1))

    temp_columns = cursor.description
    columns_data = [description[0] for description in temp_columns]
    cursor.close()

    cursor = conn.cursor()
    cursor.execute(f"DESC {table_name}")
    desc = cursor.fetchall()
    columns_desc = [description[0] for description in cursor.description]
    conn.close()
    conn.close()

    return render_template(
        "table.html",
        data=data,
        desc=desc,
        columns_desc=columns_desc,
        columns_data=columns_data,
        table_name=table_name,
        page=1,
        total_rows=0,
        rows_per_page=0,
        placeholder=query,
    )


if __name__ == "__main__":
    app.run()
