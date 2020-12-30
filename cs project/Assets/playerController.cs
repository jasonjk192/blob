﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class playerController : MonoBehaviour
{
    public float moveSpeed = 4f;
    [SerializeField]
    float vel = 0f;

    int collectibleCount;

    gameSceneHandler sceneHandler;

    Vector3 forward, right;

    void Start()
    {
        //sceneHandler = GameObject.Find("Generator").GetComponent<gameSceneHandler>();
        forward = Camera.main.transform.forward;
        forward.y = 0;
        forward = Vector3.Normalize(forward);
        right = Quaternion.Euler(new Vector3(0, 90, 0)) * forward;
        collectibleCount = 0; 
    }

    void Update()
    {
        vel = Vector3.Magnitude(GetComponent<Rigidbody>().velocity);
        if (transform.position.y < -8)
        {
            sceneHandler.gameOverSceneLoad();
        }
    }
    void FixedUpdate()
    {
        if (vel > 10)
            constants.velocityPoint += Mathf.FloorToInt(vel/10);
        if (Input.anyKey)
            Move();
    }
    void Move()
    {
        Vector3 rightMovement = right * Input.GetAxis("Horizontal");
        Vector3 upMovement = forward * Input.GetAxis("Vertical");
        Vector3 heading = Vector3.Normalize(rightMovement + upMovement);
        GetComponent<Rigidbody>().AddForce(heading * moveSpeed);
        if (Vector3.Magnitude(GetComponent<Rigidbody>().velocity) > moveSpeed)
            GetComponent<Rigidbody>().velocity = Vector3.ClampMagnitude(GetComponent<Rigidbody>().velocity, moveSpeed);
    }

    void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.CompareTag("Enemy"))
        {
            collision.gameObject.GetComponent<Rigidbody>().AddForce(GetComponent<Rigidbody>().velocity * -Vector3.Magnitude(collision.impulse));
            GetComponent<Rigidbody>().AddForce(collision.rigidbody.velocity * -Vector3.Magnitude(collision.impulse));
        }
    }

    public void collectibleCollect()
    {
        collectibleCount++;
        sceneHandler.UpdateCount(collectibleCount);
    }

    public void initSceneHandler()
    {
        sceneHandler = GameObject.Find("Generator").GetComponent<gameSceneHandler>();
        sceneHandler.UpdateCount(0);
    }
}
