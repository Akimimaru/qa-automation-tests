import requests
import pytest

BASE_URL = "https://reqres.in/api"

def test_get_single_user():
    response = requests.get(f"{BASE_URL}/users/2")
    assert response.status_code == 200, f"Ожидали 200, получили {response.status_code}"
    data = response.json()
    assert "data" in data, "В ответе нет поля 'data'"
    assert data["data"]["id"] == 2, f"ID пользователя должен быть 2, а не {data['data']['id']}"
    assert data["data"]["email"] == "janet.weaver@reqres.in", "Email не совпадает"
    print("Тест 1 пройден: пользователь получен корректно")

def test_create_user():
    payload = {
        "name": "Yuri Bogatyrev",
        "job": "QA Engineer"
    }
    response = requests.post(f"{BASE_URL}/users", json=payload)
    assert response.status_code == 201, f"Ожидали 201 Created, получили {response.status_code}"
    data = response.json()
    assert "id" in data, "В ответе нет ID"
    assert "name" in data and data["name"] == "Yuri Bogatyrev", "Имя не совпадает"
    assert "job" in data and data["job"] == "QA Engineer", "Должность не совпадает"
    assert "createdAt" in data, "Нет времени создания"
    print("Тест 2 пройден: пользователь успешно создан")

def test_get_nonexistent_user():
    response = requests.get(f"{BASE_URL}/users/999999")
    assert response.status_code == 404, f"Ожидали 404 Not Found, получили {response.status_code}"
    data = response.json()
    assert data == {}, "Ожидали пустой объект в теле ответа при 404"
    print("Тест 3 пройден: несуществующий пользователь возвращает 404")
