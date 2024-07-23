from fastapi import APIRouter

router = APIRouter()

@router.get("/items/")
def read_items():
    return [{"name": "Item 1"}, {"name": "Item 2"}]
