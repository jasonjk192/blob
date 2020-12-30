using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class gameOverSceneManager : MonoBehaviour
{
    Canvas canvas;
    Text pointTallyText;
    void Start()
    {
        canvas = GameObject.Find("Canvas").GetComponent<Canvas>();
        pointTallyText = canvas.transform.Find("pointTallyText").GetComponent<Text>();

        int pt = Mathf.CeilToInt((constants.remainingTime * 250) + (constants.collectibleCount * 500) + (constants.opponentCount * 100) + (constants.velocityPoint));
        pointTallyText.text = "POINT TALLY : "+pt;
    }

    private void Update()
    {
        if (Input.GetButtonDown("Submit"))
        {
            biomeSelectGenerator.isNight = false;
            UnityEngine.SceneManagement.SceneManager.LoadScene("SelectionScene");
        }
    }
}
